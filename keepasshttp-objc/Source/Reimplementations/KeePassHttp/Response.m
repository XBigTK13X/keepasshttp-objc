//
//  Response.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Response.h"

@implementation Response
- (id)init: (NSString *) requestType  hash:(NSString*) hash
{
    self = [super init];
    if (self)
    {
        [self setError: nil];
        [self setSuccess: false];
        [self setCount:0];
        [self setRequestType:requestType];

        if ([Request requiresEntriesInResponse:requestType])
        {
            [self setEntries:[NSMutableArray init]];
        }
        else
        {
            [self setEntries:nil];
        }
        
        [self setVersion:[AssemblyInfo AssemblyFileVersion]];
        
        [self setHash: hash];
    }
    return self;
}

- (NSString*) toJson
{
    NSMutableString* json = [NSMutableString new];
    [json appendString:@"{"];
    if(self.RequestType != nil){
        [json appendString: [SystemConvert ToJSON:@"RequestType" value:self.RequestType]];
    }
    if(self.Error != nil){
        [json appendString: [SystemConvert ToJSON:@"Error" value:self.Error]];
    }
    if(self.Nonce != nil){
        [json appendString: [SystemConvert ToJSON:@"Nonce" value:self.Nonce]];
    }
    if(self.Verifier != nil){
        [json appendString: [SystemConvert ToJSON:@"Verifier" value:self.Verifier]];
    }
    if(self.Id != nil){
        [json appendString: [SystemConvert ToJSON:@"Id" value:self.Id]];
    }
    [json appendString: [SystemConvert ToJSON:@"Version" value:self.Version]];
    [json appendString: [SystemConvert ToJSON:@"Hash" value:self.Hash]];
    [json appendString: [SystemConvert ToJSON:@"Success" value:(self.Success)?@"true":@"false"]];
    [json deleteCharactersInRange:NSMakeRange([json length]-1, 1)];
    [json appendString:@"}"];
    return json;
}
@end
