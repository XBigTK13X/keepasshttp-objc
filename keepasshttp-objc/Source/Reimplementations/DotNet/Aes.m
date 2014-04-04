//
//  Aes.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Aes.h"

// http://stackoverflow.com/questions/2039940/any-cocoa-source-code-for-aes-encryption-decryption

@implementation Aes
+ (NSData*) decrypt:(NSString*)cipherText iv:(NSString*)iv key:(NSString*)key
{
    NSData* keyData = [SystemConvert FromBase64String:key];
    NSData* cipherData = [SystemConvert FromBase64String:cipherText];
    NSData* ivData = [SystemConvert FromBase64String:iv];
    
    size_t bufferSize           = cipherData.length + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesDecrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyData.bytes, kCCKeySizeAES256,
                                          ivData.bytes,
                                          cipherData.bytes, cipherData.length, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}
@end
