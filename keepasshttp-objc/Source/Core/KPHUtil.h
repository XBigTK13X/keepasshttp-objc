//
//  SPSKeePassUtil.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacPass.h"
#import "KeePassTypes.h"
#import "Aes.h"

@interface KPHUtil : NSObject
{
    int port;
    BOOL stopped;
}
+ (NSObject<KPHKeePassClient>*) client;
+ (void) setClient: (NSObject<KPHKeePassClient>*)client;
+ (NSString*) CryptoTransform: (NSString*) input base64in:(BOOL)base64in base64out:(BOOL)base64out aes:(Aes*)aes encrypt:(BOOL)encrypt;
+ (PwEntry *) GetConfigEntry : (BOOL) access;
+ (NSString*) KPH_ASSOCIATE_KEY_PREFIX;
@end
