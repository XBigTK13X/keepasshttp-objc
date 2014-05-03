//
//  KPHCore.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHCore.h"
#import "KPHEntryConfig.h"

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
+ (KPHPwEntry *) GetConfigEntry: (BOOL) create
{
    KPHPwGroup* root = [[KPHUtil client] rootGroup];
    NSUUID* uuid = [KPHUtil globalVars].KEEPASSHTTP_UUID;
    KPHPwEntry* entry = [root findEntry:uuid searchRecursive:false];
    if (entry == nil && create)
    {
        entry = [[KPHPwEntry alloc] init:false setTimes:true];
        entry.Uuid = uuid;
        [entry.Strings setObject:[KPHUtil globalVars].KEEPASSHTTP_NAME forKey:[KPHUtil globalVars].PwDefs.TitleField];
        [root addEntry:entry takeOwnership:true];
        [[KPHUtil client] updateUI];
    }
    return entry;
}
+ (KPHEntryConfig*) GetEntryConfig: (KPHPwEntry*) entry
{
    if (entry.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME] != nil)
    {
        NSString* json = entry.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME];
        return[[KPHEntryConfig alloc]initWithJson:json];
    }
    return nil;
}
+ (void) SetEntryConfig:(KPHPwEntry*)entry entryConfig:(KPHEntryConfig*)entryConfig
{
    entry.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME] = [entryConfig toJson];
    [[KPHUtil client] saveEntry:entry];
    [[KPHUtil client] updateUI];
}
+ (NSArray*) GetUserPass:(KPHPwEntry *)entry
{
    NSString* user = entry.Strings[[KPHUtil globalVars].PwDefs.UserNameField];
    NSString* pass = entry.Strings[[KPHUtil globalVars].PwDefs.PasswordField];
    return [[NSArray alloc]initWithObjects:user,pass, nil];
}
+ (KPHResponseEntry*) PrepareElementForResponseEntries:(KPHConfigOpt*) configOpt entry:(KPHPwEntry*) entry
{
    NSString* name = entry.Strings[[KPHUtil globalVars].PwDefs.TitleField];
    NSArray* loginpass = [KPHCore GetUserPass:entry];
    NSString* login = loginpass[0];
    NSString* passwd = loginpass[1];
    NSString* uuid = [entry.Uuid UUIDString];
    
    NSMutableArray *fields = nil;
    if (configOpt.ReturnStringFields)
    {
        fields = [NSMutableArray new];
        for(NSString* sf in entry.Strings)
        {
            if ([sf hasPrefix:@"KPH: "])
            {
                NSString* sfValue = entry.Strings[sf];
                [fields addObject:[[KPHResponseStringField alloc] init:[sf substringFromIndex:5] value:sfValue]];
            }
        }
        
        if (fields.count > 0)
        {
            //var fields2 = from e2 in fields orderby e2.Key ascending select e2;
            //fields = fields2.ToList<ResponseStringField>();
        }
        else
        {
            fields = nil;
        }
    }
    
    return [[KPHResponseEntry alloc] init:name login:login password:passwd uuid:uuid stringFields:fields];
}
@end
