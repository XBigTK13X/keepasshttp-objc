//
//  SPSProtocol.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHProtocol.h"
#import "SystemConvert.h"
#import "KPHKeePassUtil.h"

@implementation KPHProtocol

+ (NSString *)encode64:(Byte *) b
{
    return [SystemConvert ToBase64String:b];
}

+ (Byte *)decode64:(NSString *) s
{
    return [SystemConvert FromBase64String:s];
}
+ (BOOL) VerifyRequest:(Request *) r aes:(Aes *) aes
{
    /*
    PwEntry* entry = [KPHKeePassUtil GetConfigEntry:false];
    if (entry == nil)
        return false;
    NSString* s = [entry getString:ASSOCIATE_KEY_PREFIX + r.Id];
    if (s == nil)
        return false;
    
    return TestRequestVerifier(r, aes, s.ReadString());
}

+ (BOOL) TestRequestVerifier: (Request *) r aes:(Aes *) aes key:(NSString *) key
{
    var success = false;
    var crypted = decode64(r.Verifier);
    
    aes.Key = decode64(key);
    aes.IV = decode64(r.Nonce);
    
    using (var dec = aes.CreateDecryptor())
    {
        try {
            var buf = dec.TransformFinalBlock(crypted, 0, crypted.Length);
            var value = Encoding.UTF8.GetString(buf);
            success = value == r.Nonce;
        } catch (CryptographicException) { } // implicit failure
    }
    return success;
}

+ (void) SetResponseVerifier: (Response *) r aes:(Aes *) aes
{
    aes.GenerateIV();
    r.Nonce = encode64(aes.IV);
    r.Verifier = CryptoTransform(r.Nonce, false, true, aes, CMode.ENCRYPT);
*/
    return nil;
     }

@end
