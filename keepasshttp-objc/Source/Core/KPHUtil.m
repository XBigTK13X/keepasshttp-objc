//
//  SPSKeePassUtil.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHUtil.h"

const Byte KEEPASSHTTP_UUID[] = {
    0x34, 0x69, 0x7a, 0x40, 0x8a, 0x5b, 0x41, 0xc0,
    0x9f, 0x36, 0x89, 0x7d, 0x62, 0x3e, 0xcb, 0x31
};

@implementation KPHUtil
+ (PwEntry *) GetConfigEntry: (BOOL) create
{
    NSString* root = [MacPass getRootGroup];
    /*
    uuid = new PwUuid(KEEPASSHTTP_UUID);
    entry = root.FindEntry(uuid, false);
    if (entry == null && create)
    {
        entry = new PwEntry(false, true);
        entry.Uuid = uuid;
        entry.Strings.Set(PwDefs.TitleField, new ProtectedString(false, KEEPASSHTTP_NAME));
        root.AddEntry(entry, true);
        UpdateUI(null);
    }
    return entry;
     */
    return nil;
}
+ (int) KPH_DEFAULT_NOTIFICATION_TIME{return 5000;}
+ (NSString*) KPH_KEEPASSHTTP_NAME{return @"KeePassHttp Settings";}
+ (NSString*) KPH_KEEPASSHTTP_GROUP_NAME{return @"KeePassHttp Passwords";}
+ (NSString*) KPH_ASSOCIATE_KEY_PREFIX{ return @"AES Key: ";}
+ (int) KPH_DEFAULT_PORT{return 19455;}
+ (NSString*) KPH_HTTP_PREFIX{return @"http://localhost:";}
@end
