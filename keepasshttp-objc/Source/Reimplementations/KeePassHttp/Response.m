//
//  Response.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Response.h"
#import "Request.h"
#import "AssemblyInfo.h"

@implementation Response
- (id)init: (NSString *) request  hash:(NSString*) hash
{
    Error = nil;
    Success = false;
    Count = 0;
    RequestType = request;

    if ([request isEqualToString:Request_GET_LOGINS] || [request isEqualToString:Request_GET_ALL_LOGINS] || [request isEqualToString:Request_GENERATE_PASSWORD])
    {
        Entries = [NSMutableArray init];
    }
    else
    {
        Entries = nil;
    }
    
    Version = AssemblyFileVersion;
    
    Hash = hash;
    return self;
}
@end
