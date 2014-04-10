//
//  SPSKeePassUtil.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHUtil.h"

const int KPH_DEFAULT_NOTIFICATION_TIME =  5000;
const NSString* KPH_KEEPASSHTTP_NAME =  @"KeePassHttp Settings";
const NSString* KPH_KEEPASSHTTP_GROUP_NAME =  @"KeePassHttp Passwords";
int KPH_DEFAULT_PORT = 19455;
NSString* KPH_HTTP_PREFIX = @"http://localhost:";
const unsigned char KPH_KEEPASSHTTP_UUID[16] = {0x34, 0x69, 0x7a, 0x40, 0x8a, 0x5b, 0x41, 0xc0,0x9f, 0x36, 0x89, 0x7d, 0x62, 0x3e, 0xcb, 0x31};

@implementation KPHUtil

static NSObject<KPHKeePassClient> *singleton;

+ (NSObject<KPHKeePassClient>*) client
{
    @synchronized(self)
    {
        if(singleton == nil){
            [NSException raise:@"Uninitialized KPHKeePassClient" format:@"[KPHUtil setClient] has not been called."];
        }
        return singleton;
    }
}
+ (void) setClient: (NSObject<KPHKeePassClient>*)client
{
    @synchronized(self)
    {
        singleton = client;
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
    PwUuid* uuid = [[PwUuid alloc] initWithUUID:[KPHUtil getUuid]];
    PwEntry* entry = [root findEntry:uuid searchRecursive:false];
    if (entry == nil && create)
    {
        entry = [[PwEntry alloc] init:false setTimes:true];
        entry->Uuid = uuid;
        [entry->Strings setObject:KPH_KEEPASSHTTP_NAME forKey:[PwDefs TitleField]];
        [root addEntry:entry takeOwnership:true];
        [[KPHUtil client] UpdateUI];
    }
    return entry;
    return nil;
}

+ (NSData*) getUuid
{
    NSData* uuid = [[NSData alloc] initWithBytes:KPH_KEEPASSHTTP_UUID length:16];
    return uuid;
}

+ (NSString*) KPH_ASSOCIATE_KEY_PREFIX
{
    return  @"AES Key: ";
}
@end
