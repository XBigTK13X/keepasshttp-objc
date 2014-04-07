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

const CCAlgorithm kAlgorithm = kCCAlgorithmAES128;
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
const NSUInteger kAlgorithmBlockSize = kCCBlockSizeAES128;
const NSUInteger kAlgorithmIVSize = kCCBlockSizeAES128;
const NSUInteger kPBKDFSaltSize = 8;
const NSUInteger kPBKDFRounds = 10000;

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
    size_t bufferSize           = cipherText.length + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesDecrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          [key bytes], kCCKeySizeAES256,
                                          [iv bytes],
                                          [cipherText bytes], cipherText.length, /* input */
                                          buffer, bufferSize, /* output */
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
    size_t outLength;
    NSMutableData *
    cipherData = [NSMutableData dataWithLength:plainText.length +
                  kAlgorithmBlockSize];
    
    CCCryptorStatus
    result = CCCrypt(kCCEncrypt, // operation
                     kAlgorithm, // Algorithm
                     kCCOptionPKCS7Padding, // options
                     key.bytes, // key
                     key.length, // keylength
                     iv.bytes,// iv
                     plainText.bytes, // dataIn
                     plainText.length, // dataInLength,
                     cipherData.mutableBytes, // dataOut
                     cipherData.length, // dataOutAvailable
                     &outLength); // dataOutMoved
    
    if (result == kCCSuccess) {
        cipherData.length = outLength;
        return cipherData;
    }
    return nil;
}

+ (void) test
{
    NSString* plainText = @"Four score and seven years ago";
    NSString* password = @"OVHNK0OQG11qDBnkXFC1i/ohaG/uPRoNBPSXCGEm3lg=";

    NSData* passwordData = [SystemConvert FromBase64String:password];
    NSData* nonce = [Aes randomIV:32];
    NSData* plainData = [SystemConvert FromUTF8String:plainText];
    
    NSData* encrypted = [Aes encrypt:plainData iv:nonce key:passwordData];
    NSString* encryptedString = [SystemConvert ToBase64String:encrypted];
    if(encrypted == nil){
        NSLog(@"Encryption failed");
        return;
    }
    NSLog(@"Encrypted result: %lu [ %@ ]",(unsigned long)encrypted.length,encryptedString);
    NSLog(@"Test AES - expecting: [ %@ ]",plainText);
    
    NSData* rawDecrypted= [Aes decrypt:encrypted iv:nonce key:passwordData];
    NSString* decrypted = [SystemConvert ToUTF8String:rawDecrypted];
    
    NSLog(@"Test AES - actual: [ %@ ]",decrypted);
    NSLog(@"Test Pass : %@",([decrypted isEqual:plainText])?@"Yes":@"No");
}
@end
