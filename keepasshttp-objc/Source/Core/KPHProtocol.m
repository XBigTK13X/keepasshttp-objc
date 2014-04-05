//
//  SPSProtocol.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHProtocol.h"

@implementation KPHProtocol

+ (BOOL) TestRequestVerifier: (Request *) r key:(NSString *) key
{
    NSData *decryptedData = [Aes decrypt:r->Verifier iv:r->Nonce key:key];
    if(decryptedData == nil){
        return false;
    }

    NSString* verifier = [SystemConvert ToUTF8String:decryptedData];
    return [verifier isEqual:r->Nonce];
}


+ (BOOL) VerifyRequest:(Request *) r
{    
    PwEntry* entry = [KPHUtil GetConfigEntry:false];
    if (entry == nil){
        return false;
    }
    NSString* entryLookup = [NSString stringWithFormat:@"%@/%@",[KPHUtil KPH_ASSOCIATE_KEY_PREFIX],r->Id];
    NSString* s = [entry getString:entryLookup];
    if (s == nil)
        return false;
    
    return [self TestRequestVerifier:r key:s];
}

+ (void) SetResponseVerifier: (Response *) r
{
    NSData* iv = [Aes randomIV:16];
    r->Nonce = [SystemConvert ToBase64String:iv];
    NSData* encrypted = [Aes encrypt: r->Nonce iv:r->Nonce key:@""];
    r->Verifier = [SystemConvert ToBase64String:encrypted];
}

@end
