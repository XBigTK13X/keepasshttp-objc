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
+ (KPHEntryConfig*) GetEntryConfig: (PwEntry*) entry
{
    return nil;
}
+ (void) SetEntryConfig:(PwEntry*)entry entryConfig:(KPHEntryConfig*)entryConfig
{
    var serializer = NewJsonSerializer();
    var writer = new StringWriter();
    serializer.Serialize(writer, c);
    e.Strings.Set(KEEPASSHTTP_NAME, new ProtectedString(false, writer.ToString()));
    e.Touch(true);
    UpdateUI(e.ParentGroup);
}
+ (NSArray*) GetUserPass:(PwEntry *)entry
{
    return nil;
}
+ (ResponseEntry*) PrepareElementForResponseEntries:(KPHConfigOpt*) configOpt entry:(PwEntry*) entry
{
    var name = entryDatabase.entry.Strings.ReadSafe(PwDefs.TitleField);
    var loginpass = GetUserPass(entryDatabase);
    var login = loginpass[0];
    var passwd = loginpass[1];
    var uuid = entryDatabase.entry.Uuid.ToHexString();
    
    List<ResponseStringField> fields = null;
    if (configOpt.ReturnStringFields)
    {
        fields = new List<ResponseStringField>();
        foreach (var sf in entryDatabase.entry.Strings)
        {
            if (sf.Key.StartsWith("KPH: "))
            {
                var sfValue = entryDatabase.entry.Strings.ReadSafe(sf.Key);
                fields.Add(new ResponseStringField(sf.Key.Substring(5), sfValue));
            }
        }
        
        if (fields.Count > 0)
        {
            var fields2 = from e2 in fields orderby e2.Key ascending select e2;
            fields = fields2.ToList<ResponseStringField>();
        }
        else
        {
            fields = null;
        }
    }
    
    return new ResponseEntry(name, login, passwd, uuid, fields);
}
@end
