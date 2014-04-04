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

@interface Aes : NSObject
+ (NSData*) decrypt:(NSString*)cipherText iv:(NSString*)iv key:(NSString*)key;
@end
