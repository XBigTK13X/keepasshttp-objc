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
    if(self.handlers == nil){
        self.handlers = [KPHHandlers new];
    }
    NSString* requestBody = [SystemConvert ToUTF8String:postDataChunk];
    NSError *error = NULL;
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithJSONString:requestBody error:&error];
    NSLog(@"===========================================\nReceived request: %@",requestBody);
    Request* pluginRequest = [[Request alloc] init :requestDictionary];
    
    NSString* rootUuid =[[[KPHUtil client] rootGroup].Uuid UUIDString];
    NSString* recycleUuid = [[[KPHUtil client] recycleGroup].Uuid UUIDString];
    NSString* hash = [[NSString stringWithFormat:@"%@%@", rootUuid, recycleUuid] sha1];
    Response* handlerResponse = [[Response alloc] init:pluginRequest.RequestType hash:hash];
    
    NSObject<KPHRequestHandler> *handler = [self.handlers forRequest:pluginRequest.RequestType];
    if(handler == nil){
        NSLog(@"No handler is registered for request: [%@]",pluginRequest.RequestType);
    }
    else{
        NSLog(@"Handling request type: %@",pluginRequest.RequestType);
        Aes* aes = [Aes new];
        BOOL requestIsValid = [pluginRequest.RequestType isEqual:@"associate"] || [KPHProtocol VerifyRequest:pluginRequest aes:aes];
        if (requestIsValid)
        {
            [handler handle:pluginRequest response:handlerResponse aes:aes];
            [KPHProtocol SetResponseVerifier:handlerResponse aes:aes];
        }
        else
        {
            NSLog(@"Unable to verify request. No handler called");
        }
    }
    
    NSString* responseBody = [handlerResponse toJson];
    NSLog(@"Responding with: %@",responseBody);
    NSData* response = [responseBody dataUsingEncoding:NSUTF8StringEncoding];
    httpResponse =  [[HTTPDataResponse alloc] initWithData:response];
}
@end
