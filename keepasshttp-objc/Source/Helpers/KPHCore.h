//
//  KPHCore.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHTypes.h"
#import "KPHUtil.h"
#import "Aes.h"
#import "KPHEntryConfig.h"
#import "KPHResponseEntry.h"
#import "KPHConfigOpt.h"

@interface KPHCore : NSObject
+ (NSString*) CryptoTransform: (NSString*) input base64in:(BOOL)base64in base64out:(BOOL)base64out aes:(Aes*)aes encrypt:(BOOL)encrypt;
+ (KPHPwEntry *) GetConfigEntry : (BOOL) access;
+ (KPHEntryConfig*) GetEntryConfig: (KPHPwEntry*) entry;
+ (void) SetEntryConfig:(KPHPwEntry*)entry entryConfig:(KPHEntryConfig*)entryConfig;
+ (NSArray*) GetUserPass:(KPHPwEntry*)entry;
+ (KPHResponseEntry*) PrepareElementForResponseEntries:(KPHConfigOpt*) configOpt entry:(KPHPwEntry*) entry;
@end
