//
//  KPHSetLoginHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHSetLoginHandler.h"

@implementation KPHSetLoginHandler
- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes
{
    NSString* url = [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false];
    NSString* urlHost = [KPHUtil getHost:url];
    
    
    NSString* username = [KPHCore CryptoTransform:request.Login base64in:true base64out:false aes:aes encrypt:false];
    NSString* password = [KPHCore CryptoTransform:request.Password base64in:true base64out:false aes:aes encrypt:false];
    
    if (request.Uuid != nil)
    {
        NSString* decryptedUuid = [KPHCore CryptoTransform:request.Uuid base64in:true base64out:false aes:aes encrypt:false];
        NSData* uuidData = [SystemConvert FromUTF8String:decryptedUuid];
        PwUuid* uuid = [[PwUuid alloc] initWithUUID:uuidData];
        UpdateEntry(uuid, username, password, urlHost, r.Id);
    }
    else
    {
        CreateEntry(username, password, urlHost, url, request, aes);
    }
    
    response.Success = true;
    response.Id = request.Id;
    [KPHProtocol SetResponseVerifier:response aes:aes];
}
- (BOOL) UpdateEntry:(PwUuid*) uuid username:(NSString*) username password:(NSString*) password formHost:(NSString*) formHost requestId:(NSString*) requestId
{
    PwEntry* entry = nil;
    
    KPHConfigOpt* configOpt = [[KPHConfigOpt alloc] initWithCustomConfig:[[KPHUtil client] getCustomConfig]];
    if (configOpt.SearchInAllOpenedDatabases)
    {
        for (PwDocument* doc in host.MainWindow.DocumentManager.Documents)
        {
            if (doc.Database.IsOpen)
            {
                entry = doc.Database.RootGroup.FindEntry(uuid, true);
                if (entry != null)
                {
                    break;
                }
            }
        }
    }
    else
    {
        entry = host.Database.RootGroup.FindEntry(uuid, true);
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
            PwObjectList<PwEntry> m_vHistory = entry.History.CloneDeep();
            entry.History = m_vHistory;
            entry.CreateBackup(null);
            
            entry.Strings.Set(PwDefs.UserNameField, new ProtectedString(false, username));
            entry.Strings.Set(PwDefs.PasswordField, new ProtectedString(true, password));
            entry.Touch(true, false);
            UpdateUI(entry.ParentGroup);
            
            return true;
        }
    }
    
    return false;
}

- (BOOL) CreateEntry: (NSString*) username password:(NSString*) password urlHost:(NSString*) urlHost url:(NSString*) url request:(Request*) request aes:(Aes*) aes
{
    string realm = null;
    if (r.Realm != null)
        realm = CryptoTransform(r.Realm, true, false, aes, CMode.DECRYPT);
    
    var root = host.Database.RootGroup;
    var group = root.FindCreateGroup(KEEPASSHTTP_GROUP_NAME, false);
    if (group == null)
    {
        group = new PwGroup(true, true, KEEPASSHTTP_GROUP_NAME, PwIcon.WorldComputer);
        root.AddGroup(group, true);
        UpdateUI(null);
    }
    
    string submithost = null;
    if (r.SubmitUrl != null)
        submithost = GetHost(CryptoTransform(r.SubmitUrl, true, false, aes, CMode.DECRYPT));
    
    string baseUrl = url;
    // index bigger than https:// <-- this slash
    if (baseUrl.LastIndexOf("/") > 9)
    {
        baseUrl = baseUrl.Substring(0, baseUrl.LastIndexOf("/") + 1);
    }
    
    PwEntry entry = new PwEntry(true, true);
    entry.Strings.Set(PwDefs.TitleField, new ProtectedString(false, urlHost));
    entry.Strings.Set(PwDefs.UserNameField, new ProtectedString(false, username));
    entry.Strings.Set(PwDefs.PasswordField, new ProtectedString(true, password));
    entry.Strings.Set(PwDefs.UrlField, new ProtectedString(true, baseUrl));
    
    if ((submithost != null && urlHost != submithost) || realm != null)
    {
        var config = new KeePassHttpEntryConfig();
        if (submithost != null)
            config.Allow.Add(submithost);
        if (realm != null)
            config.Realm = realm;
        
        var serializer = NewJsonSerializer();
        var writer = new StringWriter();
        serializer.Serialize(writer, config);
        entry.Strings.Set(KEEPASSHTTP_NAME, new ProtectedString(false, writer.ToString()));
    }
    
    group.AddEntry(entry, true);
    UpdateUI(group);
    
    return true;
}
@end
