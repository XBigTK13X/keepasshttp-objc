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
+ (PwEntry *) GetConfigEntry: (BOOL) create
{
    PwGroup* root = [[KPHUtil client] rootGroup];
    NSUUID* uuid = [[KPHUtil globalVars] KEEPASSHTTP_UUID];
    PwEntry* entry = [root findEntry:uuid searchRecursive:false];
    if (entry == nil && create)
    {
        entry = [[PwEntry alloc] init:false setTimes:true];
        entry.Uuid = uuid;
        [entry.Strings setObject:[KPHUtil globalVars].KEEPASSHTTP_NAME forKey:[KPHUtil globalVars].PwDefs.TitleField];
        [root addEntry:entry takeOwnership:true];
        [[KPHUtil client] updateUI];
    }
    return entry;
}
+ (KPHEntryConfig*) GetEntryConfig: (PwEntry*) entry
{
    return nil;
}
+ (void) SetEntryConfig:(PwEntry*)entry entryConfig:(KPHEntryConfig*)entryConfig
{
    entry.Strings[[KPHUtil globalVars].KEEPASSHTTP_NAME] = [entryConfig toJson];
    [entry Touch:true];
    [[KPHUtil client] updateUI];
}
+ (NSArray*) GetUserPass:(PwEntry *)entry
{
    return nil;
}
+ (ResponseEntry*) PrepareElementForResponseEntries:(KPHConfigOpt*) configOpt entry:(PwEntry*) entry
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
                [fields addObject:[[ResponseStringField alloc] init:[sf substringFromIndex:5] value:sfValue]];
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
    
    return [[ResponseEntry alloc] init:name login:login password:passwd uuid:uuid stringFields:fields];
}
@end
