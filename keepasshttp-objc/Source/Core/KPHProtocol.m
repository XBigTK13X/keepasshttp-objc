//
//  SPSProtocol.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHProtocol.h"

@implementation KPHProtocol

+ (BOOL) TestRequestVerifier: (Request *) request key:(NSString *) key
{
    NSData* cipherData = [SystemConvert FromBase64String:request->Verifier];
    NSData* keyData = [SystemConvert FromBase64String:key];
    NSData* ivData = [SystemConvert FromBase64String:request->Nonce];
    NSData *decryptedData = [Aes decrypt:cipherData iv:ivData key:keyData];
    if(decryptedData == nil){
        return false;
    }

    NSString* verifier = [SystemConvert ToUTF8String:decryptedData];
    return [verifier isEqual:request->Nonce];
}


+ (BOOL) VerifyRequest:(Request *) request
{    
    PwEntry* entry = [KPHUtil GetConfigEntry:false];
    if (entry == nil){
        return false;
    }
    NSString* connectionId = [NSString stringWithFormat:@"%@/%@",[KPHUtil KPH_ASSOCIATE_KEY_PREFIX],request->Id];
    NSString* connectionPassword = [entry getString:connectionId];
    if (connectionPassword == nil)
        return false;
    
    return [KPHProtocol TestRequestVerifier:request key:connectionPassword];
}

+ (void) SetResponseVerifier: (Request *) request response:(Response *) response
{
    NSData* iv = [Aes randomIV:16];
    response->Nonce = [SystemConvert ToBase64String:iv];
    NSData* keyData = [SystemConvert FromBase64String:request->Key];
    NSData* encrypted = [Aes encrypt: iv iv:iv key:keyData];
    response->Verifier = [SystemConvert ToBase64String:encrypted];
}

@end
