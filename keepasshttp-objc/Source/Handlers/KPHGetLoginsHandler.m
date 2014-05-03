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
- (KPHEntryConfig*) getEntryConfig:(KPHPwEntry*) e
{
    if (e.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME] != nil)
    {
        NSString* json = e.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME];
        KPHEntryConfig* config = [[KPHEntryConfig alloc] initWithJson:json];
        return config;
    }
    return nil;
}

- (BOOL) filter:(KPHPwEntry*)e host:(NSString*)host submithost:(NSString*)submithost
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

- (void) handle: (KPHRequest*)request response:(KPHResponse*)response aes:(Aes*)aes
{
    NSObject<KPHKeePassClient>* client = [KPHUtil client];
    NSString* submithost;
    NSString* host = [KPHUtil getHost: [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false]];
    if (request.SubmitUrl != nil)
        submithost = [KPHUtil getHost: [KPHCore CryptoTransform:request.SubmitUrl base64in:true base64out:false aes:aes encrypt:false]];
    
    NSMutableArray* items = [client findMatchingEntries:host submithost:submithost];
    if (items.count > 0)
    {
        KPHConfigOpt* configOpt = [KPHConfigOpt new];
        KPHPwEntry* config = [KPHCore GetConfigEntry:true];
        NSString* autoAllowS = config.Strings[@"Auto Allow"];
        BOOL autoAllow = autoAllowS != nil && [KPHUtil trim:autoAllowS] != nil;
        autoAllow = autoAllow || [client getConfigBool:configOpt.AlwaysAllowAccess];
        
        NSMutableArray* needPrompting = [self getEntriesThatNeedPrompting:items host:host submithost:submithost];
        
        if (needPrompting.count > 0 && !autoAllow)
        {
            NSUInteger c = needPrompting.count;
            NSString* message = [[NSString alloc] initWithFormat:@"%@ has requested access to passwords for the above %@.%@ Please select whether you want to allow access%@.",host,(c==1)?@"item" : @"items",(c==1)? @"" : @"\nYou can only grant access to all items.", (c==1)?@"" : @" to all of them"];
            KPHGetLoginsUserResponse* userResponse = [[KPHUtil client] promptUserForAccess:message title:@"" host:host submithost:submithost entries:needPrompting];
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
        
        if(items.count > 0){
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
            for(KPHPwEntry* entry in items)
            {
                NSString* entryUrl = entry.Strings[[KPHUtil globalVars].PwDefs.UrlField];
                if ([KPHUtil stringIsNilOrEmpty:entryUrl])
                {
                    entryUrl = entry.Strings[[KPHUtil globalVars].PwDefs.TitleField];
                }
                
                entryUrl = [entryUrl lowercaseString];
                
                entry.UsageCount = [self LevenshteinDistance:compareToUrl target:entryUrl];
                
            }
            if (configOpt.SpecificMatchingOnly)
            {
                KPHPwEntry* lowestScoring;
                for(KPHPwEntry* item in items){
                    if(lowestScoring == nil || item.UsageCount < lowestScoring.UsageCount){
                        lowestScoring = item;
                    }
                }
                
                items = [NSMutableArray arrayWithObject:lowestScoring];
                
            }
            else
            {
                if (configOpt.SortResultByUsername)
                {
                    items = [[NSMutableArray alloc] initWithArray: [items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        KPHPwEntry *first = (KPHPwEntry*)a;
                        KPHPwEntry *second = (KPHPwEntry*)b;
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
                    }]];

                }
                else
                {
                    items = [[NSMutableArray alloc] initWithArray:[items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        KPHPwEntry *first = (KPHPwEntry*)a;
                        KPHPwEntry *second = (KPHPwEntry*)b;
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
                    }]];
                }
            }
            
            for (KPHPwEntry* entry in items)
            {
                KPHResponseEntry* e = [KPHCore PrepareElementForResponseEntries:configOpt entry:entry];
                [response.Entries addObject:e];
            }
            
            if (items.count > 0)
            {
                NSMutableSet* distinctNames = [NSMutableSet new];
                for(KPHResponseEntry* e in response.Entries){
                    if(e.Name != nil){
                        [distinctNames addObject:e.Name];
                    }
                    else
                    {
                        [distinctNames addObject:host];
                    }
                }
                NSString* n = [[distinctNames allObjects] componentsJoinedByString:@"\n    "];
                
                if (configOpt.ReceiveCredentialNotification){
                    [[KPHUtil client] showNotification:[NSString stringWithFormat:@"%@:%@ is receiving credentials for:\n    %@", request.Id, host, n]];
                }
            }
            
            [KPHProtocol encryptResponse:response aes:aes];        
            response.Count = response.Entries.count;
        }
        else{
            NSLog(@"User rejected all access requests");
        }
    }
    else
    {
        NSLog(@"No matching entries found");
    }
    response.Success = true;
    response.Id = request.Id;
    [KPHProtocol SetResponseVerifier:response aes:aes];
}
- (NSUInteger) LevenshteinDistance:(NSString*) source target:(NSString*) target
{
    if ([KPHUtil stringIsNilOrEmpty:source])
    {
        if ([KPHUtil stringIsNilOrEmpty:target]) return 0;
        return target.length;
    }
    if ([KPHUtil stringIsNilOrEmpty:target]) return source.length;
    
    if (source.length > target.length)
    {
        NSString* temp = target;
        target = source;
        source = temp;
    }
    
    NSUInteger m = target.length;
    NSUInteger n = source.length;
    NSUInteger distance[2][m + 1];
    // Initialize the distance 'matrix'
    for (int j = 1; j <= m; j++) distance[0][j] = j;
    
    int currentRow = 0;
    for (int i = 1; i <= n; ++i)
    {
        currentRow = i & 1;
        distance[currentRow][0] = i;
        int previousRow = currentRow ^ 1;
        for (int j = 1; j <= m; j++)
        {
            NSUInteger cost = ([target characterAtIndex:(j - 1)] == [source characterAtIndex:(i - 1)]) ? 0 : 1;
            
            NSUInteger firstDistStep = [KPHUtil min:(distance[previousRow][j] + 1) second:(distance[currentRow][j - 1] + 1)];
            distance[currentRow][j] = [KPHUtil min:firstDistStep second:(distance[previousRow][j - 1] + cost)];
        }
    }
    return distance[currentRow][m];
}
@end
