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
private bool UpdateEntry(PwUuid uuid, string username, string password, string formHost, string requestId)
{
    PwEntry entry = null;
    
    var configOpt = new ConfigOpt(this.host.CustomConfig);
    if (configOpt.SearchInAllOpenedDatabases)
    {
        foreach (PwDocument doc in host.MainWindow.DocumentManager.Documents)
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
    
    if (entry == null)
    {
        return false;
    }
    
    string[] up = GetUserPass(entry);
    var u = up[0];
    var p = up[1];
    
    if (u != username || p != password)
    {
        bool allowUpdate = configOpt.AlwaysAllowUpdates;
        
        if (!allowUpdate)
        {
            host.MainWindow.Activate();
            
            DialogResult result;
            if (host.MainWindow.IsTrayed())
            {
                result = MessageBox.Show(
                                         String.Format("Do you want to update the information in {0} - {1}?", formHost, u),
                                         "Update Entry", MessageBoxButtons.YesNo,
                                         MessageBoxIcon.None, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
            }
            else
            {
                result = MessageBox.Show(
                                         host.MainWindow,
                                         String.Format("Do you want to update the information in {0} - {1}?", formHost, u),
                                         "Update Entry", MessageBoxButtons.YesNo,
                                         MessageBoxIcon.Information, MessageBoxDefaultButton.Button1);
            }
            
            
            if (result == DialogResult.Yes)
            {
                allowUpdate = true;
            }
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

private bool CreateEntry(string username, string password, string urlHost, string url, Request r, Aes aes)
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
