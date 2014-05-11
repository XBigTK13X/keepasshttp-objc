//
//  Aes.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHAes.h"

// http://stackoverflow.com/questions/2039940/any-cocoa-source-code-for-aes-encryption-decryption
// http://stackoverflow.com/questions/4917968/best-way-to-generate-nsdata-object-with-random-bytes-of-a-specific-length

const CCAlgorithm ALGORITHM = kCCAlgorithmAES128;
const NSUInteger ALGORITHM_BLOCK_SIZE = kCCBlockSizeAES128;
const NSUInteger ALGORITHM_OPTIONS = kCCOptionPKCS7Padding;
const NSUInteger ALGORITHM_KEY_SIZE = kCCKeySizeAES256;

@implementation KPHAes
+ (NSData*) randomIV: (unsigned int)lengthInBytes
{
    NSMutableData* result = [NSMutableData dataWithCapacity:lengthInBytes];
    for( unsigned int i = 0 ; i < lengthInBytes ; ++i )
    {
        u_int32_t randomBits = arc4random()%255;
        [result appendBytes:(void*)&randomBits length:1];
    }
    return result;
}

- (id) init:(NSData*)key iv:(NSData*)iv
{
    self = [super init];
    if(self){
        self.Key = key;
        self.IV = iv;
    }
    return self;
}


- (NSData*) decrypt:(NSData*)cipherText
{
    size_t bufferSize           = cipherText.length + ALGORITHM_BLOCK_SIZE;
    void* buffer                = malloc(bufferSize);

    size_t numBytesDecrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(
                                    kCCDecrypt, ALGORITHM, ALGORITHM_OPTIONS,
                                    self.Key.bytes, ALGORITHM_KEY_SIZE,
                                    self.IV.bytes,
                                    cipherText.bytes, cipherText.length,
                                    buffer, bufferSize,
                                    &numBytesDecrypted);

    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)encrypt:(NSData *)plainText
{
    size_t bufferSize = plainText.length + ALGORITHM_BLOCK_SIZE;
    void* buffer      = malloc(bufferSize);
    
    size_t numBytesEncrypted    = 0;
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt,ALGORITHM,ALGORITHM_OPTIONS,
                     self.Key.bytes,ALGORITHM_KEY_SIZE,
                     self.IV.bytes,
                     plainText.bytes,plainText.length,
                     buffer,bufferSize,
                     &numBytesEncrypted);
    
    if (result == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}
@end
