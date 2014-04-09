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
#import "Aes.h"

@interface KPHUtil : NSObject
{
    int port;
    BOOL stopped;
}
+ (NSString*) CryptoTransform: (NSString*) input base64in:(BOOL)base64in base64out:(BOOL)base64out aes:(Aes*)aes encrypt:(BOOL)encrypt;
+ (PwEntry *) GetConfigEntry : (BOOL) access;
+ (int) KPH_DEFAULT_NOTIFICATION_TIME;
+ (NSString*) KPH_KEEPASSHTTP_NAME;
+ (NSString*) KPH_KEEPASSHTTP_GROUP_NAME;
+ (NSString*) KPH_ASSOCIATE_KEY_PREFIX;
+ (int) KPH_DEFAULT_PORT;
+ (NSString*) KPH_HTTP_PREFIX;
@end
