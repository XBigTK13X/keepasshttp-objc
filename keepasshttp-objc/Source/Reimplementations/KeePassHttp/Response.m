//
//  Response.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Response.h"

@implementation Response
- (id)init: (NSString *) request  hash:(NSString*) hash
{
    self = [super init];
    if (self)
    {
        Error = nil;
        Success = false;
        Count = 0;
        RequestType = request;

        if ([request isEqualToString:[Request GET_LOGINS]] || [request isEqualToString:[Request GET_ALL_LOGINS]] || [request isEqualToString:[Request GENERATE_PASSWORD]])
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
@end
