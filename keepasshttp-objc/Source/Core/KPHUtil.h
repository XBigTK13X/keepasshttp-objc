//
//  SPSKeePassUtil.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PwEntry.h"
#import "MacPass.h"

@interface KPHUtil : NSObject
{
    int port;
    BOOL stopped;
}
+ (PwEntry *) GetConfigEntry : (BOOL) access;
+ (int) KPH_DEFAULT_NOTIFICATION_TIME;
+ (NSString*) KPH_KEEPASSHTTP_NAME;
+ (NSString*) KPH_KEEPASSHTTP_GROUP_NAME;
+ (NSString*) KPH_ASSOCIATE_KEY_PREFIX;
+ (int) KPH_DEFAULT_PORT;
+ (NSString*) KPH_HTTP_PREFIX;
@end
