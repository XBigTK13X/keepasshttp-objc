//
//  Aes.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Aes.h"

// http://stackoverflow.com/questions/2039940/any-cocoa-source-code-for-aes-encryption-decryption
// http://stackoverflow.com/questions/4917968/best-way-to-generate-nsdata-object-with-random-bytes-of-a-specific-length

@implementation Aes
+ (NSData*) randomIV: (unsigned int)lengthInBytes
{
    NSMutableData* result = [NSMutableData dataWithCapacity:lengthInBytes];
    for( unsigned int i = 0 ; i < lengthInBytes ; ++i )
    {
        u_int32_t randomBits = arc4random();
        [result appendBytes:(void*)&randomBits length:1];
    }
    return result;
}

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

+ (NSData*) encrypt:(NSString*)plainText iv:(NSString*)iv key:(NSString*)key
{
    return nil;
}
@end
