//
//  KPHGlobalVars.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGlobalVars.h"
#import "SystemConvert.h"

@implementation KPHGlobalVars
- (id) init
{
    self = [super init];
    if(self)
    {
        self.ASSOCIATE_KEY_PREFIX =  @"AES Key: ";
        self.DEFAULT_NOTIFICATION_TIME = 5000;
        self.KEEPASSHTTP_NAME =  @"KeePassHttp Settings";
        self.KEEPASSHTTP_GROUP_NAME =  @"KeePassHttp Passwords";
        self.DEFAULT_PORT = 19455;
        self.HTTP_PREFIX = @"http://localhost:";
        const unsigned char uuidBase[16] = {0x34, 0x69, 0x7a, 0x40, 0x8a, 0x5b, 0x41, 0xc0,0x9f, 0x36, 0x89, 0x7d, 0x62, 0x3e, 0xcb, 0x31};
        NSData* uuid = [[NSData alloc]initWithBytes:uuidBase length:16];
        self.KEEPASSHTTP_UUID = [[NSUUID alloc] initWithUUIDBytes:uuid.bytes];
        self.PwDefs = [KPHPwDefs new];
        self.RequestIds = [KPHRequestIds new];
    }
    return self;
}
@end
