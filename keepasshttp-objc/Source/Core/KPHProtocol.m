//
//  SPSProtocol.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHProtocol.h"

@implementation KPHProtocol

+ (NSString *)encode64:(NSArray *) b
{
    return [SystemConvert ToBase64String:b];
}

+ (NSArray *)decode64:(NSString *) s
{
    return [SystemConvert FromBase64String:s];
}

+ (BOOL) TestRequestVerifier: (Request *) r aes:(Aes *) aes key:(NSString *) key
{
    bool success = false;
    NSArray* crypted = [self decode64:r->Verifier];
    
    /*
    aes->Key = [self decode64:key];
    aes->IV = [self decode64:r->Nonce];
    
    using (var dec = aes.CreateDecryptor())
    {
        try {
            var buf = dec.TransformFinalBlock(crypted, 0, crypted.Length);
            var value = Encoding.UTF8.GetString(buf);
            success = value == r.Nonce;
        } catch (CryptographicException) { } // implicit failure
    }
    return success;
     */
    return false;
}


+ (BOOL) VerifyRequest:(Request *) r aes:(Aes *) aes
{
    
    PwEntry* entry = [KPHUtil GetConfigEntry:false];
    if (entry == nil){
        return false;
    }
    NSString* entryLookup = [NSString stringWithFormat:@"%@/%@",[KPHUtil KPH_ASSOCIATE_KEY_PREFIX],r->Id];
    NSString* s = [entry getString:entryLookup];
    if (s == nil)
        return false;
    
    return [self TestRequestVerifier:r aes:aes key:s];
}

+ (void) SetResponseVerifier: (Response *) r aes:(Aes *) aes
{
    /*
    aes->GenerateIV();
    r->Nonce = encode64(aes.IV);
    r->Verifier = CryptoTransform(r->Nonce, false, true, aes, CMode.ENCRYPT);
     */
}

@end
