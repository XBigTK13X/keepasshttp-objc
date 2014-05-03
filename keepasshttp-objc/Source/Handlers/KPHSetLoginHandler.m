//
//  KPHSetLoginHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHSetLoginHandler.h"

@implementation KPHSetLoginHandler
- (void) handle: (KPHRequest*)request response:(KPHResponse*)response aes:(Aes*)aes
{
    NSString* url = [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false];
    NSString* urlHost = [KPHUtil getHost:url];
    
    
    NSString* username = [KPHCore CryptoTransform:request.Login base64in:true base64out:false aes:aes encrypt:false];
    NSString* password = [KPHCore CryptoTransform:request.Password base64in:true base64out:false aes:aes encrypt:false];
    
    if (request.Uuid != nil)
    {
        NSString* decryptedUuid = [KPHCore CryptoTransform:request.Uuid base64in:true base64out:false aes:aes encrypt:false];
        NSData* uuidData = [SystemConvert FromUTF8String:decryptedUuid];
        NSUUID* uuid = [[NSUUID alloc] initWithUUIDBytes:uuidData.bytes];
        [self UpdateEntry:uuid username:username password:password formHost:urlHost requestId:request.Id];
    }
    else
    {
        [self CreateEntry:username password:password urlHost:urlHost url:url request:request aes:aes];
    }
    
    response.Success = true;
    response.Id = request.Id;
    [KPHProtocol SetResponseVerifier:response aes:aes];
}
- (BOOL) UpdateEntry:(NSUUID*) uuid username:(NSString*) username password:(NSString*) password formHost:(NSString*) formHost requestId:(NSString*) requestId
{
    KPHPwEntry* entry = nil;
    
    KPHConfigOpt* configOpt = [[KPHConfigOpt alloc] initWithCustomConfig:[[KPHUtil client] getCustomConfig]];
    if (configOpt.SearchInAllOpenedDatabases)
    {
        entry = [[KPHUtil client] findEntryInAnyDatabase:uuid searchRecursive:true];
    }
    else
    {
        entry = [[[KPHUtil client] rootGroup] findEntry:uuid searchRecursive:true];
    }
    
    if (entry == nil)
    {
        return false;
    }
    
    NSArray* up = [KPHCore GetUserPass:entry];
    NSString* u = [up objectAtIndex:0];
    NSString* p = [up objectAtIndex:1];
    
    if (![u isEqual: username] || ![p isEqual:password])
    {
        bool allowUpdate = configOpt.AlwaysAllowUpdates;
        
        if (!allowUpdate)
        {
            NSString* message = [[NSString alloc] initWithFormat:@"Do you want to update the information in %@ - %@?", formHost, u ];
            allowUpdate = [[KPHUtil client] promptUserForEntryUpdate:message title:@"Update Entry"];
        }
        
        if (allowUpdate)
        {
            //PwObjectList<PwEntry> m_vHistory = entry.History.CloneDeep();
            //entry.History = m_vHistory;
            //entry.CreateBackup(null);
            
            entry.Strings[[KPHUtil globalVars].PwDefs.UserNameField] = username;
            entry.Strings[[KPHUtil globalVars].PwDefs.PasswordField] = password;
            [[KPHUtil client] saveEntry:entry];
            [[KPHUtil client] updateUI];
            
            return true;
        }
    }
    
    return false;
}

- (BOOL) CreateEntry: (NSString*) username password:(NSString*) password urlHost:(NSString*) urlHost url:(NSString*) url request:(KPHRequest*) request aes:(Aes*) aes
{
    NSString* realm = nil;
    if (request.Realm != nil)
    {
        realm = [KPHCore CryptoTransform:request.Realm base64in:true base64out:false aes:aes encrypt:false];
    }
    
    KPHPwGroup* root = [[KPHUtil client] rootGroup];
    KPHPwGroup* group = [root findCreateGroup:[KPHUtil globalVars].KEEPASSHTTP_GROUP_NAME createIfNotFound:false];
    if (group == nil)
    {
        group = [[KPHPwGroup alloc] initWithParams:true setTimes:true name:[KPHUtil globalVars].KEEPASSHTTP_GROUP_NAME pwIcon:[KPHUtil globalVars].KEEPASSHTTP_GROUP_ICON];
        [root AddGroup:group takeOwnership:true];
        [[KPHUtil client] updateUI];
    }
    
    NSString* submithost = nil;
    if (request.SubmitUrl != nil)
    {
        submithost = [KPHCore CryptoTransform:request.SubmitUrl base64in:true base64out:false aes:aes encrypt:false];
    }
    NSString* baseUrl = url;
    // index bigger than https:// <-- this slash
    NSUInteger lastSlashLocation = [baseUrl rangeOfString:@"/" options:NSBackwardsSearch].location;
    if (lastSlashLocation > 9)
    {
        baseUrl = [baseUrl substringWithRange:NSMakeRange(0, lastSlashLocation+1)];
    }
    
    KPHPwEntry* entry = [[KPHPwEntry alloc] init:true setTimes:true];
    entry.Strings[[KPHUtil globalVars].PwDefs.TitleField] = urlHost;
    entry.Strings[[KPHUtil globalVars].PwDefs.UserNameField] = username;
    entry.Strings[[KPHUtil globalVars].PwDefs.PasswordField] = password;
    entry.Strings[[KPHUtil globalVars].PwDefs.UrlField] = baseUrl;
    
    if ((submithost != nil && ![urlHost isEqual:submithost]) || realm != nil)
    {
        KPHEntryConfig* config = [KPHEntryConfig new];
        if (submithost != nil)
            [config.Allow addObject:submithost];
        if (realm != nil)
            config.Realm = realm;
        
        entry.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME] = [config toJson];
    }
    
    [group addEntry:entry takeOwnership:true];
    [[KPHUtil client] updateUI];
    
    return true;
}
@end
