//
//  SPSProtocol.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHProtocol.h"
#import "KPHLogging.h"

@implementation KPHProtocol

+ (BOOL) verifyRequestt:(KPHRequest *) request aes:(KPHAes*)aes
{
    KPHPwEntry* entry = [KPHCore getConfigEntry:false];
    if (entry == nil){
        return false;
    }
    NSString* connectionId = [KPHUtil associateKeyId:request.Id];
    NSString* pluginCryptoKey = entry.Strings[connectionId];
    if (pluginCryptoKey == nil){
        return false;
    }
    
    return [KPHProtocol testRequestVerifier:request aes:aes key:pluginCryptoKey];
}

+ (BOOL) testRequestVerifier: (KPHRequest *) request aes:(KPHAes*)aes key:(NSString *) key
{
    NSData* cipherData = [KPHSystemConvert fromBase64String:request.Verifier];
    aes.Key = [KPHSystemConvert fromBase64String:key];
    aes.IV = [KPHSystemConvert fromBase64String:request.Nonce];
    NSData *decryptedData = [aes decrypt:cipherData];
    if(decryptedData == nil){
        return false;
    }

    NSString* verifier = [KPHSystemConvert toUTF8String:decryptedData];
    return [verifier isEqual:request.Nonce];
}

+ (void) setResponseVerifier: (KPHResponse *) response aes:(KPHAes*) aes
{
    if(response.Nonce == nil){
        [KPHProtocol randomizeIV:response aes:aes];
    }
    response.Verifier = [KPHCore cryptoTransform:response.Nonce base64in:false base64out:true aes:aes encrypt:true];
    
}

+ (void) randomizeIV: (KPHResponse *) response aes:(KPHAes*) aes
{
    aes.IV = [KPHAes randomIV:16];
    response.Nonce = [KPHSystemConvert toBase64String:aes.IV];
}

+ (void) encryptResponse:(KPHResponse*)response aes:(KPHAes*)aes
{
    [KPHProtocol randomizeIV:response aes:aes];
    for (KPHResponseEntry* entry in response.Entries)
    {
        if(entry.Name != nil){
            entry.Name = [KPHCore cryptoTransform:entry.Name base64in:false base64out:true aes:aes encrypt:true];
        }
        if(entry.Login != nil){
            entry.Login = [KPHCore cryptoTransform:entry.Login base64in:false base64out:true aes:aes encrypt:true];
        }
        if(entry.Uuid != nil){
            entry.Uuid = [KPHCore cryptoTransform:entry.Uuid base64in:false base64out:true aes:aes encrypt:true];
        }
        if(entry.Password != nil){
            entry.Password = [KPHCore cryptoTransform:entry.Password base64in:false base64out:true aes:aes encrypt:true];
        }
        
        if (entry.StringFields != nil)
        {
            for (KPHResponseStringField* sf in entry.StringFields)
            {
                sf.Key = [KPHCore cryptoTransform:sf.Key base64in:false base64out:true aes:aes encrypt:true];
                sf.Value = [KPHCore cryptoTransform:sf.Value base64in:false base64out:true aes:aes encrypt:true];
            }
        }
    }
}
@end
