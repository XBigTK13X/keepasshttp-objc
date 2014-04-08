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

const CCAlgorithm ALGORITHM = kCCAlgorithmAES128;
const NSUInteger ALGORITHM_BLOCK_SIZE = kCCBlockSizeAES128;
const NSUInteger ALGORITHM_OPTIONS = kCCOptionPKCS7Padding;
const NSUInteger ALGORITHM_KEY_SIZE = kCCKeySizeAES256;

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

+ (NSData*) decrypt:(NSData*)cipherText iv:(NSData*)iv key:(NSData*)key
{
    size_t bufferSize           = cipherText.length + ALGORITHM_BLOCK_SIZE;
    void* buffer                = malloc(bufferSize);

    size_t numBytesDecrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(
                                    kCCDecrypt, ALGORITHM, ALGORITHM_OPTIONS,
                                    key.bytes, ALGORITHM_KEY_SIZE,
                                    iv.bytes,
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

+ (NSData *)encrypt:(NSData *)plainText iv:(NSData*)iv key:(NSData *)key
{
    size_t bufferSize = plainText.length + ALGORITHM_BLOCK_SIZE;
    void* buffer      = malloc(bufferSize);
    
    size_t numBytesEncrypted    = 0;
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt,ALGORITHM,ALGORITHM_OPTIONS,
                     key.bytes,ALGORITHM_KEY_SIZE,
                     iv.bytes,
                     plainText.bytes,plainText.length,
                     buffer,bufferSize,
                     &numBytesEncrypted);
    
    if (result == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

+ (NSData*) testDecrypt: (NSString*)cipher iv:(NSString*)iv key:(NSString*)key expected:(NSString*)expected
{
    NSData* inData = [SystemConvert FromBase64String:cipher];
    NSData* ivData = [SystemConvert FromBase64String:iv];
    NSData* keyData = [SystemConvert FromBase64String:key];
    
    NSData* decrypted = [Aes decrypt:inData iv:ivData key:keyData];
    if(decrypted == nil){
        return nil;
    }
    NSString* decryptedText = [SystemConvert ToBase64String:decrypted];
    NSLog(@"Decrypted : %@",decryptedText);
    NSLog(@"Should be : %@",expected);
    NSLog(@"Test Pass : %@",([decryptedText isEqual:expected])?@"Yes":@"No");
    return decrypted;
}

+ (NSData*) testEncrypt: (NSString*)plain iv:(NSString*)iv key:(NSString*)key
{
    NSData* inData = [SystemConvert FromBase64String:plain];
    NSData* ivData = [SystemConvert FromBase64String:iv];
    NSData* keyData = [SystemConvert FromBase64String:key];

    NSData* encrypted = [Aes encrypt:inData iv:ivData key:keyData];
    if(encrypted == nil){
        NSLog(@"Encryption failed");
        return nil;
    }
    NSString* encryptedString = [SystemConvert ToBase64String:encrypted];
    NSLog(@"Encrypted result: %lu [ %@ ]",(unsigned long)encrypted.length,encryptedString);
    return encrypted;
}


+ (void) test
{
    
    NSString* pluginKey = @"CekqCTOIQvjx1GyX4Cypl3lfKZ4rUUPYsVmCavkseMo=";
    NSString* pluginNonce = @"SmXsbPYhAbpCr0oZXfDFd0twEDa+1Ml9L2rFEGHjD1o=";
    NSString* pluginVerifier = @"Ug3YpyjKyn3aiBEPTPukWVC6dKqywdH6VbtniMz/P1zhHCQdCUtdIll3fVRQV9xZ";
    [self testDecrypt:pluginVerifier iv:pluginNonce key:pluginKey expected:pluginNonce];
    
    NSString* plainText = [SystemConvert ToBase64String:[SystemConvert FromUTF8String:@"Alpha Bravo Charlie Delta Erie Foxtrot Golf Hotel India Juliet"]];
    [self testDecrypt: [SystemConvert ToBase64String:[self testEncrypt:plainText iv:pluginNonce key:pluginKey]] iv:pluginNonce key:pluginKey expected:plainText];
    
    NSString* generatedNonce = [SystemConvert ToBase64String:[Aes randomIV:16]];
    [self testDecrypt: [SystemConvert ToBase64String:[self testEncrypt:plainText iv:generatedNonce key:pluginKey]] iv:generatedNonce key:pluginKey expected:plainText];
}
@end
