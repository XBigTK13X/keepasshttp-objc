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

+ (BOOL) VerifyRequest:(KPHRequest *) request aes:(Aes*)aes
{
    KPHPwEntry* entry = [KPHCore GetConfigEntry:false];
    if (entry == nil){
        return false;
    }
    NSString* connectionId = [KPHUtil associateKeyId:request.Id];
    NSString* pluginCryptoKey = entry.Strings[connectionId];
    if (pluginCryptoKey == nil){
        return false;
    }
    
    return [KPHProtocol TestRequestVerifier:request aes:aes key:pluginCryptoKey];
}

+ (BOOL) TestRequestVerifier: (KPHRequest *) request aes:(Aes*)aes key:(NSString *) key
{
    NSData* cipherData = [SystemConvert FromBase64String:request.Verifier];
    aes.Key = [SystemConvert FromBase64String:key];
    aes.IV = [SystemConvert FromBase64String:request.Nonce];
    NSData *decryptedData = [aes decrypt:cipherData];
    if(decryptedData == nil){
        return false;
    }

    NSString* verifier = [SystemConvert ToUTF8String:decryptedData];
    return [verifier isEqual:request.Nonce];
}

+ (void) SetResponseVerifier: (KPHResponse *) response aes:(Aes*) aes
{
    if(response.Nonce == nil){
        [KPHProtocol randomizeIV:response aes:aes];
    }
    response.Verifier = [KPHCore CryptoTransform:response.Nonce base64in:false base64out:true aes:aes encrypt:true];
    
}

+ (void) randomizeIV: (KPHResponse *) response aes:(Aes*) aes
{
    aes.IV = [Aes randomIV:16];
    response.Nonce = [SystemConvert ToBase64String:aes.IV];
}

+ (void) encryptResponse:(KPHResponse*)response aes:(Aes*)aes
{
    [KPHProtocol randomizeIV:response aes:aes];
    for (KPHResponseEntry* entry in response.Entries)
    {
        if(entry.Name != nil){
            entry.Name = [KPHCore CryptoTransform:entry.Name base64in:false base64out:true aes:aes encrypt:true];
        }
        if(entry.Login != nil){
            entry.Login = [KPHCore CryptoTransform:entry.Login base64in:false base64out:true aes:aes encrypt:true];
        }
        if(entry.Uuid != nil){
            entry.Uuid = [KPHCore CryptoTransform:entry.Uuid base64in:false base64out:true aes:aes encrypt:true];
        }
        if(entry.Password != nil){
            entry.Password = [KPHCore CryptoTransform:entry.Password base64in:false base64out:true aes:aes encrypt:true];
        }
        
        if (entry.StringFields != nil)
        {
            for (KPHResponseStringField* sf in entry.StringFields)
            {
                sf.Key = [KPHCore CryptoTransform:sf.Key base64in:false base64out:true aes:aes encrypt:true];
                sf.Value = [KPHCore CryptoTransform:sf.Value base64in:false base64out:true aes:aes encrypt:true];
            }
        }
    }
}
@end
