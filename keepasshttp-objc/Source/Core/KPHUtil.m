//
//  SPSKeePassUtil.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHUtil.h"

@implementation KPHUtil

static NSObject<KPHKeePassClient> *clientSingleton;
static KPHGlobalVars *globalVarsSingleton;
+ (KPHGlobalVars*) globalVars
{
    @synchronized(self)
    {
        if(globalVarsSingleton == nil){
            globalVarsSingleton = [KPHGlobalVars new];
        }
        return globalVarsSingleton;
    }
}
+ (NSObject<KPHKeePassClient>*) client
{
    @synchronized(self)
    {
        return clientSingleton;
    }
}
+ (void) setClient: (NSObject<KPHKeePassClient>*)client
{
    @synchronized(self)
    {
        clientSingleton = client;
    }
}

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
    PwGroup* root = [[KPHUtil client] getRootGroup];
    PwUuid* uuid = [[PwUuid alloc] initWithUUID:[[KPHUtil globalVars] KEEPASSHTTP_UUID]];
    PwEntry* entry = [root findEntry:uuid searchRecursive:false];
    if (entry == nil && create)
    {
        entry = [[PwEntry alloc] init:false setTimes:true];
        [entry setUuid:uuid];
        [entry.Strings setObject:[[KPHUtil globalVars] KEEPASSHTTP_NAME] forKey:[PwDefs TitleField]];
        [root addEntry:entry takeOwnership:true];
        [[KPHUtil client] UpdateUI];
    }
    return entry;
    return nil;
}
@end
