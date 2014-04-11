//
//  KPHGetLoginsHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGetLoginsHandler.h"
#import "KPHEntryConfig.h"
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
    return ![title isEqual:host] && ![entryUrl isEqual:host] || (submithost != null && ![title isEqual:submithost] && ![entryUrl isEqual:submithost]);
}

- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes
{
    NSString* submithost;
    NSString* host = [KPHUtil getHost: [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false]];
    if (request.SubmitUrl != nil)
        submithost = [KPHUtil getHost: [KPHCore CryptoTransform:request.SubmitUrl base64in:true base64out:false aes:aes encrypt:false]];
    
    NSArray* items = [[KPHUtil client] findMatchingEntries:request aes:aes];
    if (items.count > 0)
    {
        var configOpt = new ConfigOpt(this.host.CustomConfig);
        var config = GetConfigEntry(true);
        var autoAllowS = config.Strings.ReadSafe("Auto Allow");
        var autoAllow = autoAllowS != null && autoAllowS.Trim() != "";
        autoAllow = autoAllow || configOpt.AlwaysAllowAccess;
        var needPrompting = from e in items where filter(e.entry) select e;
        
        if (needPrompting.ToList().Count > 0 && !autoAllow)
        {
            var win = this.host.MainWindow;
            
            using (var f = new AccessControlForm())
            {
                win.Invoke((MethodInvoker)delegate
                           {
                               f.Icon = win.Icon;
                               f.Plugin = this;
                               f.Entries = (from e in items where filter(e.entry) select e.entry).ToList();
                               //f.Entries = needPrompting.ToList();
                               f.Host = submithost != null ? submithost : host;
                               f.Load += delegate { f.Activate(); };
                               f.ShowDialog(win);
                               if (f.Remember && (f.Allowed || f.Denied))
                               {
                                   foreach (var e in needPrompting)
                                   {
                                       var c = GetEntryConfig(e.entry);
                                       if (c == null)
                                           c = new KeePassHttpEntryConfig();
                                       var set = f.Allowed ? c.Allow : c.Deny;
                                       set.Add(host);
                                       if (submithost != null && submithost != host)
                                           set.Add(submithost);
                                       SetEntryConfig(e.entry, c);
                                       
                                   }
                               }
                               if (!f.Allowed)
                               {
                                   items = items.Except(needPrompting);
                               }
                           });
            }
        }
        
        string compareToUrl = null;
        if (r.SubmitUrl != null)
        {
            compareToUrl = CryptoTransform(r.SubmitUrl, true, false, aes, CMode.DECRYPT);
        }
        if(String.IsNullOrEmpty(compareToUrl))
            compareToUrl = CryptoTransform(r.Url, true, false, aes, CMode.DECRYPT);
        
        compareToUrl = compareToUrl.ToLower();
        
        foreach (var entryDatabase in items)
        {
            string entryUrl = String.Copy(entryDatabase.entry.Strings.ReadSafe(PwDefs.UrlField));
            if (String.IsNullOrEmpty(entryUrl))
                entryUrl = entryDatabase.entry.Strings.ReadSafe(PwDefs.TitleField);
            
            entryUrl = entryUrl.ToLower();
            
            entryDatabase.entry.UsageCount = (ulong)LevenshteinDistance(compareToUrl, entryUrl);
            
        }
        
        var itemsList = items.ToList();
        
        if (configOpt.SpecificMatchingOnly)
        {
            itemsList = (from e in itemsList
                         orderby e.entry.UsageCount ascending
                         select e).ToList();
            
            ulong lowestDistance = itemsList[0].entry.UsageCount;
            
            itemsList = (from e in itemsList
                         where e.entry.UsageCount == lowestDistance
                         orderby e.entry.UsageCount
                         select e).ToList();
            
        }
        
        if (configOpt.SortResultByUsername)
        {
            var items2 = from e in itemsList orderby e.entry.UsageCount ascending, GetUserPass(e)[0] ascending select e;
            itemsList = items2.ToList();
        }
        else
        {
            var items2 = from e in itemsList orderby e.entry.UsageCount ascending, e.entry.Strings.ReadSafe(PwDefs.TitleField) ascending select e;
            itemsList = items2.ToList();
        }
        
        foreach (var entryDatabase in itemsList)
        {
            var e = PrepareElementForResponseEntries(configOpt, entryDatabase);
            resp.Entries.Add(e);
        }
        
        if (itemsList.Count > 0)
        {
            var names = (from e in resp.Entries select e.Name).Distinct<string>();
            var n = String.Join("\n    ", names.ToArray<string>());
            
            if (configOpt.ReceiveCredentialNotification)
                ShowNotification(String.Format("{0}: {1} is receiving credentials for:\n    {2}", r.Id, host, n));
        }
        
        resp.Success = true;
        resp.Id = r.Id;
        SetResponseVerifier(resp, aes);
        
        foreach (var entry in resp.Entries)
        {
            entry.Name = CryptoTransform(entry.Name, false, true, aes, CMode.ENCRYPT);
            entry.Login = CryptoTransform(entry.Login, false, true, aes, CMode.ENCRYPT);
            entry.Uuid = CryptoTransform(entry.Uuid, false, true, aes, CMode.ENCRYPT);
            entry.Password = CryptoTransform(entry.Password, false, true, aes, CMode.ENCRYPT);
            
            if (entry.StringFields != null)
            {
                foreach (var sf in entry.StringFields)
                {
                    sf.Key = CryptoTransform(sf.Key, false, true, aes, CMode.ENCRYPT);
                    sf.Value = CryptoTransform(sf.Value, false, true, aes, CMode.ENCRYPT);
                }
            }
        }
        
        resp.Count = resp.Entries.Count;
    }
    else
    {
        resp.Success = true;
        resp.Id = r.Id;
        SetResponseVerifier(resp, aes);
    }
}
@end
