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
    NSLog(@"Sending reply: %@",httpResponse);
    return httpResponse;
}
- (void)processBodyData:(NSData *)postDataChunk
{
    if(handlers == nil){
        handlers = [KPHHandlers new];
    }
    NSString* requestBody = [SystemConvert ToUTF8String:postDataChunk];
    NSError *error = NULL;
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithJSONString:requestBody error:&error];
    NSLog(@"===========================================\nReceived request: %@",requestBody);
    Request* pluginRequest = [[Request alloc] init :requestDictionary];
    
    NSString* hash = [[NSString stringWithFormat:@"%@%@", [[KPHUtil client] getRootGroupUUID], [[KPHUtil client] getRecycleGroupUUID]] sha1];
    Response* handlerResponse = [[Response alloc] init:pluginRequest->RequestType hash:hash];
    
    NSObject<KPHRequestHandler> *handler = [handlers forRequest:pluginRequest->RequestType];
    if(handler == nil){
        NSLog(@"No handler is registered for request: [%@]",pluginRequest->RequestType);
    }
    else{
        NSLog(@"Handling request type: %@",pluginRequest->RequestType);
        Aes* aes = [Aes new];
        [handler handle:pluginRequest response:handlerResponse aes:aes];
    }
    
    NSString* responseBody = [handlerResponse toJson];
    NSLog(@"Responding with: %@",responseBody);
    NSData* response = [responseBody dataUsingEncoding:NSUTF8StringEncoding];
    httpResponse =  [[HTTPDataResponse alloc] initWithData:response];
}
@end
