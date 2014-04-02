//
//  SPSHttpConnection.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHHttpConnection.h"

@implementation KPHHttpConnection
- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    return YES;
}

- (BOOL) expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
    NSLog(@"Expects request body:  %@ -> %@",method,path);
    return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    NSLog(@"Received request:  %@ -> %@",method,path);
    
    NSData* response = nil;
    response = [@"Successful client attachment" dataUsingEncoding:NSUTF8StringEncoding];
    return [[HTTPDataResponse alloc] initWithData:response];
}

@end
