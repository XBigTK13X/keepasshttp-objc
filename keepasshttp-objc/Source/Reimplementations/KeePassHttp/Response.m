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
        Error = nil;
        Success = false;
        Count = 0;
        RequestType = requestType;

        if ([Request requiresEntriesInResponse:requestType])
        {
            Entries = [NSMutableArray init];
        }
        else
        {
            Entries = nil;
        }
        
        Version = [AssemblyInfo AssemblyFileVersion];
        
        Hash = hash;
    }
    return self;
}

- (NSString*) toJson
{
    /*
    @public NSString* RequestType;
    @public NSString* Error;
    @public BOOL Success;
    @public NSString* Id;
    @public int Count;
    @public NSString* Version;
    @public NSString* Hash;
    @public NSArray* Entries;
    @public NSString* Nonce;
    @public NSString* Verifier;
     */
    NSMutableString* json = [NSMutableString new];
    [json appendString:@"{"];
    if(self->RequestType != nil){
        [json appendString: [SystemConvert ToJSON:@"RequestType" value:self->RequestType]];
    }
    if(self->Error != nil){
        [json appendString: [SystemConvert ToJSON:@"Error" value:self->Error]];
    }
    if(self->Nonce != nil){
        [json appendString: [SystemConvert ToJSON:@"Nonce" value:self->Nonce]];
    }
    if(self->Verifier != nil){
        [json appendString: [SystemConvert ToJSON:@"Verifier" value:self->Verifier]];
    }
    [json appendString: [SystemConvert ToJSON:@"Success" value:(self->Success)?@"true":@"false"]];
    [json deleteCharactersInRange:NSMakeRange([json length]-1, 1)];
    [json appendString:@"}"];
    return json;
}
@end
