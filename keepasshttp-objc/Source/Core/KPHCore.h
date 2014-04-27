//
//  KPHCore.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeePassTypes.h"
#import "KPHUtil.h"
#import "Aes.h"
#import "KPHEntryConfig.h"
#import "ResponseEntry.h"
#import "KPHConfigOpt.h"

@interface KPHCore : NSObject
+ (NSString*) CryptoTransform: (NSString*) input base64in:(BOOL)base64in base64out:(BOOL)base64out aes:(Aes*)aes encrypt:(BOOL)encrypt;
+ (PwEntry *) GetConfigEntry : (BOOL) access;
+ (KPHEntryConfig*) GetEntryConfig: (PwEntry*) entry;
+ (void) SetEntryConfig:(PwEntry*)entry entryConfig:(KPHEntryConfig*)entryConfig;
+ (NSArray*) GetUserPass:(PwEntry*)entry;
+ (ResponseEntry*) PrepareElementForResponseEntries:(KPHConfigOpt*) configOpt entry:(PwEntry*) entry;
@end
