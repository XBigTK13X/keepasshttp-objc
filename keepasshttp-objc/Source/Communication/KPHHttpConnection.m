//
//  SPSHttpConnection.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHHttpConnection.h"

@implementation KPHHttpConnection
+ (int) defaultPort
{
    return 19455;
}
- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    return YES;
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    LogTrace(@"Sending reply: %@",httpResponse);
    return httpResponse;
}
- (void)processBodyData:(NSData *)postDataChunk
{    
    NSString* requestBody = [SystemConvert ToUTF8String:postDataChunk];
    NSString* responseBody = [self.engine respondAsJSON:requestBody];
    LogTrace(@"Responding with: %@",responseBody);
    NSData* response = [responseBody dataUsingEncoding:NSUTF8StringEncoding];
    httpResponse =  [[HTTPDataResponse alloc] initWithData:response];
}
@end
