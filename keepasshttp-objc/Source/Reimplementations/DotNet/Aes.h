//
//  Aes.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "SystemConvert.h"
#import "stdlib.h"

@interface Aes : NSObject
+ (NSData*) encrypt:(NSData*) plainText iv:(NSData*) iv key:(NSData *)key;
+ (NSData*) decrypt:(NSData*) cipherText iv:(NSData*) iv key:(NSData*)key;
+ (NSData*) randomIV: (unsigned int)lengthInBytes;
+ (void) test;
@end
