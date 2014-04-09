//
//  SPSProtocol.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHProtocol.h"

@implementation KPHProtocol

+ (BOOL) VerifyRequest:(Request *) request aes:(Aes*)aes
{
    PwEntry* entry = [KPHUtil GetConfigEntry:false];
    if (entry == nil){
        return false;
    }
    NSString* connectionId = [NSString stringWithFormat:@"%@/%@",[KPHUtil KPH_ASSOCIATE_KEY_PREFIX],request->Id];
    NSString* connectionPassword = [entry getString:connectionId];
    if (connectionPassword == nil)
        return false;
    
    return [KPHProtocol TestRequestVerifier:request aes:aes key:connectionPassword];
}

+ (BOOL) TestRequestVerifier: (Request *) request aes:(Aes*)aes key:(NSString *) key
{
    NSData* cipherData = [SystemConvert FromBase64String:request->Verifier];
    aes->Key = [SystemConvert FromBase64String:key];
    aes->IV = [SystemConvert FromBase64String:request->Nonce];
    NSData *decryptedData = [aes decrypt:cipherData];
    if(decryptedData == nil){
        return false;
    }

    NSString* verifier = [SystemConvert ToUTF8String:decryptedData];
    return [verifier isEqual:request->Nonce];
}

+ (void) SetResponseVerifier: (Response *) response aes:(Aes*) aes
{
    
    aes->IV = [Aes randomIV:16];
    response->Nonce = [SystemConvert ToBase64String:aes->IV];
    response->Verifier = [KPHUtil CryptoTransform:response->Nonce base64in:false base64out:true aes:aes encrypt:true];
    
}

@end
