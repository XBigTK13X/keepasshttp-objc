//
//  KPHGetAllLoginsHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGetAllLoginsHandler.h"

@implementation KPHGetAllLoginsHandler
- (void) handle: (KPHRequest*)request response:(KPHResponse*)response aes:(KPHAes*)aes
{
    NSArray* entries = [[KPHUtil client] getAllLogins];
    for (KPHPwEntry* entry in entries)
    {
        NSString* name = entry.Strings[[KPHUtil globalVars].PwDefs.TitleField];
        if(name == nil){
            name = entry.Strings[[KPHUtil globalVars].PwDefs.UrlField];
        }
        NSString* login = [KPHCore getUserPass:entry][0];
        NSString* uuid = [entry.Uuid UUIDString];
        KPHResponseEntry* e = [KPHResponseEntry new];
        e.Name = name;
        e.Login = login;
        e.Uuid = uuid;
        [response.Entries addObject:e];
    }
    response.Success = true;
    response.Id = request.Id;
    [KPHProtocol setResponseVerifier:response aes:aes];
    [KPHProtocol encryptResponse:response aes:aes];
}
@end
