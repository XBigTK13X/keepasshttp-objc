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
#import "KPHAes.h"
#import "KPHEntryConfig.h"
#import "KPHResponseEntry.h"
#import "KPHConfigOpt.h"

@interface KPHCore : NSObject
+ (NSString*) cryptoTransform: (NSString*) input base64in:(BOOL)base64in base64out:(BOOL)base64out aes:(KPHAes*)aes encrypt:(BOOL)encrypt;
+ (KPHPwEntry *) getConfigEntry : (BOOL) access;
+ (KPHEntryConfig*) getEntryConfig: (KPHPwEntry*) entry;
+ (void) setEntryConfig:(KPHPwEntry*)entry entryConfig:(KPHEntryConfig*)entryConfig;
+ (NSArray*) getUserPass:(KPHPwEntry*)entry;
+ (KPHResponseEntry*) prepareElementForResponseEntries:(KPHConfigOpt*) configOpt entry:(KPHPwEntry*) entry;
@end
