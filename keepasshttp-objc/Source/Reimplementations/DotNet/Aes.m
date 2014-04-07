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

+ (void) test
{
    NSString* key = @"CekqCTOIQvjx1GyX4Cypl3lfKZ4rUUPYsVmCavkseMo=";
    NSString* debugNonce = @"SmXsbPYhAbpCr0oZXfDFd0twEDa+1Ml9L2rFEGHjD1o=";
    NSString* verifier = @"Ug3YpyjKyn3aiBEPTPukWVC6dKqywdH6VbtniMz/P1zhHCQdCUtdIll3fVRQV9xZ";
    NSData* keyData = [SystemConvert FromBase64String:key];
    NSData* nonce = [SystemConvert FromBase64String:debugNonce];//[Aes randomIV:16];
    NSData* verifierData = [SystemConvert FromBase64String:verifier];
    
    NSData* verifierDecrypt = [Aes decrypt:verifierData iv:nonce key:keyData];
    NSString* decryptedVerifier = [SystemConvert ToBase64String:verifierDecrypt];
    NSLog(@"Decrypt ver: %@",decryptedVerifier);
    NSLog(@"Should be  : %@",debugNonce);
 
    NSString* plainText = @"Alpha Bravo Charlie Delta Erie Foxtrot Golf Hotel India Juliet";
    NSData* plainData = [SystemConvert FromUTF8String:plainText];
    
    NSData* encrypted = [Aes encrypt:plainData iv:nonce key:keyData];
    NSString* encryptedString = [SystemConvert ToBase64String:encrypted];
    if(encrypted == nil){
        NSLog(@"Encryption failed");
        return;
    }
    NSLog(@"Encrypted result: %lu [ %@ ]",(unsigned long)encrypted.length,encryptedString);
    NSLog(@"Test AES - expecting: [ %@ ]",plainText);
    
    NSData* rawDecrypted= [Aes decrypt:encrypted iv:nonce key:keyData];
    NSString* decrypted = [SystemConvert ToUTF8String:rawDecrypted];
    if(decrypted == nil){
        NSLog(@"Decryption failed");
        return;
    }
    
    NSLog(@"Test AES - actual: [ %@ ]",decrypted);
    NSLog(@"Test Pass : %@",([decrypted isEqual:plainText])?@"Yes":@"No");
}
@end
