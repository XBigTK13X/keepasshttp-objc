//
//  KPHGetLoginsHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGetLoginsHandler.h"
#import "KPHEntryConfig.h"
#import "KPHUtil.h"

@implementation KPHGetLoginsHandler
- (KPHEntryConfig*) getEntryConfig:(PwEntry*) e
{
    if (e.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME] != nil)
    {
        NSString* json = e.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME];
        KPHEntryConfig* config = [[KPHEntryConfig alloc] initWithJson:json];
        return config;
    }
    return nil;
}

- (BOOL) filter:(PwEntry*)e host:(NSString*)host submithost:(NSString*)submithost
{
    KPHEntryConfig* c = [self getEntryConfig:e];
    NSString* title = e.Strings[[KPHUtil globalVars].PwDefs.TitleField];
    NSString* entryUrl = e.Strings[[KPHUtil globalVars].PwDefs.UrlField];
    if (c != nil)
    {
        return (![title isEqual:host] && ![entryUrl isEqual:host] && ![c.Allow containsObject:host]) || ( submithost != nil && ![c.Allow containsObject:submithost] && [submithost isEqual:title] && ![submithost isEqual: entryUrl]);
    }
    return (![title isEqual:host] && ![entryUrl isEqual:host]) || (submithost != nil && ![title isEqual:submithost] && ![entryUrl isEqual:submithost]);
}

- (NSMutableArray*) getEntriesThatNeedPrompting:(NSArray*)items host:(NSString*)host submithost:(NSString*)submithost
{
    NSMutableArray* needPrompting = [NSMutableArray new];
    for ( id item in items)
    {
        if([self filter:item host:host submithost:submithost]){
            [needPrompting addObject:item];
        }
    }
    return needPrompting;
}

- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes
{
    NSObject<KPHKeePassClient>* client = [KPHUtil client];
    NSString* submithost;
    NSString* host = [KPHUtil getHost: [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false]];
    if (request.SubmitUrl != nil)
        submithost = [KPHUtil getHost: [KPHCore CryptoTransform:request.SubmitUrl base64in:true base64out:false aes:aes encrypt:false]];
    
    NSMutableArray* items = [client findMatchingEntries:request aes:aes];
    if (items.count > 0)
    {
        KPHConfigOpt* configOpt = [KPHConfigOpt new];
        PwEntry* config = [KPHCore GetConfigEntry:true];
        NSString* autoAllowS = config.Strings[@"Auto Allow"];
        BOOL autoAllow = autoAllowS != nil && [KPHUtil trim:autoAllowS] != nil;
        autoAllow = autoAllow || [client getConfigBool:configOpt.AlwaysAllowAccess];
        
        NSMutableArray* needPrompting = [self getEntriesThatNeedPrompting:items host:host submithost:submithost];
        
        if (needPrompting.count > 0 && !autoAllow)
        {
            KPHGetLoginsUserResponse* userResponse = [[KPHUtil client] promptUserForAccess:host submithost:submithost entries:needPrompting];
            if(userResponse != nil)
            {
                if (userResponse.Remember)
                {
                    for (id e in needPrompting)
                    {
                        KPHEntryConfig* c = [KPHCore GetEntryConfig:e];
                        if (c == nil)
                        {
                            c =[KPHEntryConfig new];
                        }
                        NSMutableSet* set = userResponse.Accept ? c.Allow : c.Deny;
                        [set addObject:host];
                        if (submithost != nil && ![submithost isEqual: host])
                        {
                            [set addObject:submithost];
                        }
                        
                        [KPHCore SetEntryConfig:e entryConfig:c];
                        
                    }
                }
                if (!userResponse.Accept)
                {
                    for(id item in needPrompting){
                        [items removeObject:item];
                    }
                }
            }
        }

        NSString* compareToUrl = nil;
        if (request.SubmitUrl != nil)
        {
            compareToUrl = [KPHCore CryptoTransform:request.SubmitUrl base64in:true base64out:false aes:aes encrypt:false];
        }
        if([KPHUtil stringIsNilOrEmpty:compareToUrl])
        {
            compareToUrl = [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false];
        }
        
        
        compareToUrl = [compareToUrl lowercaseString];
        for(PwEntry* entry in items)
        {
            NSString* entryUrl = entry.Strings[[KPHUtil globalVars].PwDefs.UrlField];
            if ([KPHUtil stringIsNilOrEmpty:entryUrl])
            {
                entryUrl = entry.Strings[[KPHUtil globalVars].PwDefs.TitleField];
            }
            
            entryUrl = [entryUrl lowercaseString];
            
            entry.UsageCount = (u_long)LevenshteinDistance(compareToUrl, entryUrl);
            
        }
        NSArray* itemsList = [items copy];
        if (configOpt.SpecificMatchingOnly)
        {
            PwEntry* lowestScoring;
            for(PwEntry* item in items){
                if(lowestScoring == nil || item.UsageCount < lowestScoring.UsageCount){
                    lowestScoring = item;
                }
            }
            
            itemsList = [NSArray arrayWithObject:lowestScoring];
            
        }
        
        if (configOpt.SortResultByUsername)
        {
            itemsList = [items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                PwEntry *first = (PwEntry*)a;
                PwEntry *second = (PwEntry*)b;
                NSComparisonResult usageCountOrder = NSOrderedSame;
                if(first.UsageCount < second.UsageCount){
                    usageCountOrder = NSOrderedAscending;
                }
                else if(first.UsageCount > second.UsageCount){
                    usageCountOrder = NSOrderedDescending;
                }
                if(usageCountOrder == NSOrderedSame){
                    NSString* firstUserName = [[KPHCore GetUserPass:first] objectAtIndex:0];
                    NSString* secondUserName =[[KPHCore GetUserPass:second] objectAtIndex:0];
                    return [firstUserName compare:secondUserName];
                }
                return usageCountOrder;
            }];

        }
        else
        {
            itemsList = [items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                PwEntry *first = (PwEntry*)a;
                PwEntry *second = (PwEntry*)b;
                NSComparisonResult usageCountOrder = NSOrderedSame;
                if(first.UsageCount < second.UsageCount){
                    usageCountOrder = NSOrderedAscending;
                }
                else if(first.UsageCount > second.UsageCount){
                    usageCountOrder = NSOrderedDescending;
                }
                if(usageCountOrder == NSOrderedSame){
                    NSString* firstTitle = first.Strings[[KPHUtil globalVars].PwDefs.TitleField];
                    NSString* secondTitle = second.Strings[[KPHUtil globalVars].PwDefs.TitleField];
                    return [firstTitle compare:secondTitle];
                }
                return usageCountOrder;
            }];
        }
        
        for (PwEntry* entry in itemsList)
        {
            ResponseEntry* e = [KPHCore PrepareElementForResponseEntries:configOpt entry:entry];
            [response.Entries addObject:e];
        }
        
        if (itemsList.count > 0)
        {
            NSMutableSet* distinctNames = [NSMutableSet new];
            for(ResponseEntry* e in response.Entries){
                [distinctNames addObject:e.Name];
            }
            NSString* n = [[distinctNames allObjects] componentsJoinedByString:@"\n    "];
            
            if (configOpt.ReceiveCredentialNotification){
                [[KPHUtil client] showNotification:[NSString stringWithFormat:@"%@:%@ is receiving credentials for:\n    %@", request.Id, host, n]];
            }
        }
        
        for (ResponseEntry* entry in response.Entries)
        {
            entry.Name = [KPHCore CryptoTransform:entry.Name base64in:false base64out:true aes:aes encrypt:true];
            entry.Login = [KPHCore CryptoTransform:entry.Login base64in:false base64out:true aes:aes encrypt:true];
            entry.Uuid = [KPHCore CryptoTransform:entry.Uuid base64in:false base64out:true aes:aes encrypt:true];
            entry.Password = [KPHCore CryptoTransform:entry.Password base64in:false base64out:true aes:aes encrypt:true];
            
            if (entry.StringFields != nil)
            {
                for (ResponseStringField* sf in entry.StringFields)
                {
                    sf.Key = [KPHCore CryptoTransform:sf.Key base64in:false base64out:true aes:aes encrypt:true];
                    sf.Value = [KPHCore CryptoTransform:sf.Value base64in:false base64out:true aes:aes encrypt:true];
                }
            }
        }
        
        response.Count = response.Entries.count;
    }
    response.Success = true;
    response.Id = request.Id;
    [KPHProtocol SetResponseVerifier:response aes:aes];
}
@end
