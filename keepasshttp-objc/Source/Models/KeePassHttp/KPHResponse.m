//
//  Response.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHResponse.h"

@implementation KPHResponse
- (id)init: (NSString *) requestType  hash:(NSString*) hash
{
    self = [super init];
    if (self)
    {
        self.Error = nil;
        self.Success = false;
        self.Count = -1;
        self.RequestType = requestType;

        if ([KPHRequest requiresEntriesInResponse:requestType])
        {
            self.Entries = [NSMutableArray new];
        }
        else
        {
            self.Entries = nil;
        }
        
        self.Version = [KPHAssemblyInfo assemblyFileVersion];
        
        self.Hash = hash;
    }
    return self;
}

- (NSString*) toJson
{
    NSMutableString* json = [NSMutableString new];
    [json appendString:@"{"];
    if(self.RequestType != nil)
        [json appendString: [KPHSystemConvert toJSON:@"RequestType" value:self.RequestType]];
    if(self.Error != nil)
        [json appendString: [KPHSystemConvert toJSON:@"Error" value:self.Error]];
    if(self.Nonce != nil)
        [json appendString: [KPHSystemConvert toJSON:@"Nonce" value:self.Nonce]];
    if(self.Verifier != nil)
        [json appendString: [KPHSystemConvert toJSON:@"Verifier" value:self.Verifier]];
    if(self.Id != nil)
        [json appendString: [KPHSystemConvert toJSON:@"Id" value:self.Id]];
    if(self.Count != -1)
        [json appendString: [KPHSystemConvert toJSON:@"Count" value:[NSString stringWithFormat:@"%lu",(unsigned long)self.Count]]];
    [json appendString: [KPHSystemConvert toJSON:@"Version" value:self.Version]];
    [json appendString: [KPHSystemConvert toJSON:@"Hash" value:self.Hash]];
    [json appendString: [KPHSystemConvert toJSON:@"Success" value:(self.Success)?@"true":@"false"]];
    
    if(self.Entries != nil && self.Entries.count > 0){
        NSMutableString* entries = [NSMutableString new];
        [entries appendString:@"\"Entries\":["];
        for(KPHResponseEntry* entry in self.Entries){
            [entries appendString:@"{"];
            if(entry.Login != nil)
                [entries appendString: [KPHSystemConvert toJSON:@"Login" value:entry.Login]];
            if(entry.Password != nil)
               [entries appendString: [KPHSystemConvert toJSON:@"Password" value:entry.Password]];
            if(entry.Uuid != nil)
               [entries appendString: [KPHSystemConvert toJSON:@"Uuid" value:entry.Uuid]];
            if(entry.Name != nil)
               [entries appendString: [KPHSystemConvert toJSON:@"Name" value:entry.Name]];
            [entries deleteCharactersInRange:NSMakeRange([entries length]-1, 1)];
            [entries appendString:@"},"];
        }
        [entries deleteCharactersInRange:NSMakeRange([entries length]-1, 1)];
        [entries appendString:@"]"];
        [json appendString:entries];
    }
    else
    {
        [json deleteCharactersInRange:NSMakeRange([json length]-1, 1)];
    }
    
    //TODO String fields conversion to JSON
    
    [json appendString:@"}"];
    return json;
}
@end
