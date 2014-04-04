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

        if ([requestType isEqualToString:[Request GET_LOGINS]] || [requestType isEqualToString:[Request GET_ALL_LOGINS]] || [requestType isEqualToString:[Request GENERATE_PASSWORD]])
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
    [json appendString: [SystemConvert ToJSONString:self->RequestType]];
    [json appendString:@"}"];
    return json;
}
@end
