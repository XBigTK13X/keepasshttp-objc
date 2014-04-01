//
//  SPSKeePassUtil.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHKeePassUtil.h"
#import "MacPass.h"

const Byte KEEPASSHTTP_UUID[] = {
    0x34, 0x69, 0x7a, 0x40, 0x8a, 0x5b, 0x41, 0xc0,
    0x9f, 0x36, 0x89, 0x7d, 0x62, 0x3e, 0xcb, 0x31
};

static const int DEFAULT_NOTIFICATION_TIME = 5000;
static const NSString* KEEPASSHTTP_NAME = @"KeePassHttp Settings";
static const NSString* KEEPASSHTTP_GROUP_NAME = @"KeePassHttp Passwords";
static const NSString* ASSOCIATE_KEY_PREFIX = @"AES Key: ";
static const int DEFAULT_PORT = 19455;
static int port = DEFAULT_PORT;
static NSString* HTTP_PREFIX = @"http://localhost:";
static bool stopped = false;

@implementation KPHKeePassUtil
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
@end
