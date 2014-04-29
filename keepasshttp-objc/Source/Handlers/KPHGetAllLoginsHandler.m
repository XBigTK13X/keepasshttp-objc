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
    NSMutableArray* list = [NSMutableArray new];
    PwGroup *root = [[KPHUtil client] rootGroup];
    SearchParameters* parms = [SearchParameters new];
    
    parms.SearchString = @"^[A-Za-z0-9:/-]+\\.[A-Za-z0-9:/-]+$"; // match anything looking like a domain or url
    
    [root searchEntries:parms entries:list];
    for (PwEntry* entry in list)
    {
        NSString* name = entry.Strings[[KPHUtil globalVars].PwDefs.TitleField];
        NSString* login = [KPHCore GetUserPass:entry][0];
        NSString* uuid = [entry.Uuid UUIDString];
        ResponseEntry* e = [ResponseEntry new];
        e.Name = name;
        e.Login = login;
        e.Uuid = uuid;
        [response.Entries addObject:e];
    }
    response.Success = true;
    response.Id = request.Id;
    [KPHProtocol SetResponseVerifier:response aes:aes];
    [KPHProtocol encryptResponse:response aes:aes];
}
@end
