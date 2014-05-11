//
//  Aes.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "KPHSystemConvert.h"
#import "stdlib.h"

@interface KPHAes : NSObject

@property (nonatomic) NSData* Key;
@property (nonatomic) NSData* IV;

+ (NSData*) randomIV: (unsigned int)lengthInBytes;
- (id) init:(NSData*)key iv:(NSData*)iv;
- (NSData*) encrypt:(NSData*) plainText;
- (NSData*) decrypt:(NSData*) cipherText;
@end
