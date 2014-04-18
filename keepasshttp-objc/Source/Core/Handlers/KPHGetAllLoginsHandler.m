//
//  KPHGetAllLoginsHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGetAllLoginsHandler.h"

@implementation KPHGetAllLoginsHandler
- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes
{
    var list = new PwObjectList<PwEntry>();
    
    var root = host.Database.RootGroup;
    
    var parms = MakeSearchParameters();
    
    parms.SearchString = @"^[A-Za-z0-9:/-]+\.[A-Za-z0-9:/-]+$"; // match anything looking like a domain or url
    
    root.SearchEntries(parms, list);
    foreach (var entry in list)
    {
        var name = entry.Strings.ReadSafe(PwDefs.TitleField);
        var login = GetUserPass(entry)[0];
        var uuid = entry.Uuid.ToHexString();
        var e = new ResponseEntry(name, login, null, uuid, null);
        resp.Entries.Add(e);
    }
    resp.Success = true;
    resp.Id = r.Id;
    SetResponseVerifier(resp, aes);
    foreach (var entry in resp.Entries)
    {
        entry.Name = CryptoTransform(entry.Name, false, true, aes, CMode.ENCRYPT);
        entry.Login = CryptoTransform(entry.Login, false, true, aes, CMode.ENCRYPT);
        entry.Uuid = CryptoTransform(entry.Uuid, false, true, aes, CMode.ENCRYPT);
    }
}
@end
