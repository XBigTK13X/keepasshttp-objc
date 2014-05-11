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
    return httpResponse;
}
- (void)processBodyData:(NSData *)postDataChunk
{
    if(self.engine == nil){
        self.engine = [KPHDialogueEngine new];
    }
    NSString* requestBody = [KPHSystemConvert toUTF8String:postDataChunk];
    NSString* responseBody = [self.engine respondAsJSON:requestBody];
    if(responseBody == nil){
        DDLogError(@"No response was provided: %@",responseBody);
        return;
    }
    NSData* response = [responseBody dataUsingEncoding:NSUTF8StringEncoding];
    httpResponse =  [[HTTPDataResponse alloc] initWithData:response];
}
@end
