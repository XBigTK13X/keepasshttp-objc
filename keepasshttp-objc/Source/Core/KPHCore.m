//
//  KPHCore.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHCore.h"

@implementation KPHCore
+ (NSString*) CryptoTransform: (NSString*) input base64in:(BOOL)base64in base64out:(BOOL)base64out aes:(Aes*)aes encrypt:(BOOL)encrypt
{
    NSData* inBytes;
    if (base64in)
    {
        inBytes = [SystemConvert FromBase64String:input];
    }
    else
    {
        inBytes = [SystemConvert FromUTF8String:input];
    }
    NSData* outBytes;
    if(encrypt)
    {
        outBytes = [aes encrypt:inBytes];
    }
    else
    {
        outBytes = [aes decrypt:inBytes];
    }
    
    if(base64out)
    {
        return [SystemConvert ToBase64String:outBytes];
    }
    else
    {
        return [SystemConvert ToUTF8String:outBytes];
    }
}
+ (PwEntry *) GetConfigEntry: (BOOL) create
{
    PwGroup* root = [[KPHUtil client] rootGroup];
    PwUuid* uuid = [[PwUuid alloc] initWithUUID:[[KPHUtil globalVars] KEEPASSHTTP_UUID]];
    PwEntry* entry = [root findEntry:uuid searchRecursive:false];
    if (entry == nil && create)
    {
        entry = [[PwEntry alloc] init:false setTimes:true];
        entry.Uuid = uuid;
        [entry.Strings setObject:[[KPHUtil globalVars] KEEPASSHTTP_NAME] forKey:[PwDefs TitleField]];
        [root addEntry:entry takeOwnership:true];
        [[KPHUtil client] updateUI];
    }
    return entry;
}

@end
