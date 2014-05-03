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
        self.Count = 0;
        self.RequestType = requestType;

        if ([KPHRequest requiresEntriesInResponse:requestType])
        {
            self.Entries = [NSMutableArray new];
        }
        else
        {
            self.Entries = nil;
        }
        
        self.Version = [AssemblyInfo AssemblyFileVersion];
        
        self.Hash = hash;
    }
    return self;
}

- (NSString*) toJson
{
    NSMutableString* json = [NSMutableString new];
    [json appendString:@"{"];
    if(self.RequestType != nil)
        [json appendString: [SystemConvert ToJSON:@"RequestType" value:self.RequestType]];
    if(self.Error != nil)
        [json appendString: [SystemConvert ToJSON:@"Error" value:self.Error]];
    if(self.Nonce != nil)
        [json appendString: [SystemConvert ToJSON:@"Nonce" value:self.Nonce]];
    if(self.Verifier != nil)
        [json appendString: [SystemConvert ToJSON:@"Verifier" value:self.Verifier]];
    if(self.Id != nil)
        [json appendString: [SystemConvert ToJSON:@"Id" value:self.Id]];
    [json appendString: [SystemConvert ToJSON:@"Version" value:self.Version]];
    [json appendString: [SystemConvert ToJSON:@"Hash" value:self.Hash]];
    [json appendString: [SystemConvert ToJSON:@"Success" value:(self.Success)?@"true":@"false"]];
    
    if(self.Entries != nil && self.Entries.count > 0){
        NSMutableString* entries = [NSMutableString new];
        [entries appendString:@"\"Entries\":["];
        for(KPHResponseEntry* entry in self.Entries){
            [entries appendString:@"{"];
            if(entry.Password != nil){
                if(entry.Login != nil)
                    [entries appendString: [SystemConvert ToJSON:@"Login" value:entry.Login]];
                if(entry.Password != nil)
                   [entries appendString: [SystemConvert ToJSON:@"Password" value:entry.Password]];
                if(entry.Uuid != nil)
                   [entries appendString: [SystemConvert ToJSON:@"Uuid" value:entry.Uuid]];
                if(entry.Name != nil)
                   [entries appendString: [SystemConvert ToJSON:@"Name" value:entry.Name]];
                [entries deleteCharactersInRange:NSMakeRange([entries length]-1, 1)];
            }
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
