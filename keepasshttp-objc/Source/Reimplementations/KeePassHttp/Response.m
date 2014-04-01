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
    Error = nil;
    Success = false;
    Count = 0;
    Version = @"";
    Hash = @"";
    RequestType = request;
    
    /*
    if (request == Request.GET_LOGINS || request == Request.GET_ALL_LOGINS || request == Request.GENERATE_PASSWORD)
        Entries = new List<ResponseEntry>();
    else
        Entries = null;
    
    Assembly assembly = Assembly.GetExecutingAssembly();
    FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(assembly.Location);
    this.Version = fvi.ProductVersion;
    
    this.Hash = hash;
     */
    return nil;
}
@end
