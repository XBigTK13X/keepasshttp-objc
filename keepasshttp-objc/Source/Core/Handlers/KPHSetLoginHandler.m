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
    string url = CryptoTransform(r.Url, true, false, aes, CMode.DECRYPT);
    var urlHost = GetHost(url);
    
    PwUuid uuid = null;
    string username, password;
    
    username = CryptoTransform(r.Login, true, false, aes, CMode.DECRYPT);
    password = CryptoTransform(r.Password, true, false, aes, CMode.DECRYPT);
    
    if (r.Uuid != null)
    {
        uuid = new PwUuid(MemUtil.HexStringToByteArray(
                                                       CryptoTransform(r.Uuid, true, false, aes, CMode.DECRYPT)));
    }
    
    if (uuid != null)
    {
        // modify existing entry
        UpdateEntry(uuid, username, password, urlHost, r.Id);
    }
    else
    {
        // create new entry
        CreateEntry(username, password, urlHost, url, r, aes);
    }
    
    resp.Success = true;
    resp.Id = r.Id;
    SetResponseVerifier(resp, aes);
}
@end
