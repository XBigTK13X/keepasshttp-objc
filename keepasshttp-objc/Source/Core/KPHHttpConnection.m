//
//  SPSHttpConnection.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHHttpConnection.h"

@implementation KPHHttpConnection
- (id) init{
    self = [super init];
    if (self)
    {
        handlers = [NSMutableDictionary init];
        [handlers setObject:[KPHAssociationHandler init] forKey:[Request ASSOCIATE]];
    }
    return self;
}
- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    return YES;
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    NSLog(@"Received request:  %@ -> %@",method,path);
    
    NSData* response = [@"Message received" dataUsingEncoding:NSUTF8StringEncoding];
    return [[HTTPDataResponse alloc] initWithData:response];
}
- (void)processBodyData:(NSData *)postDataChunk
{
    NSLog(@"Parsing request body: %@",postDataChunk);
    
    NSString* requestBody = [[NSString alloc] initWithData:postDataChunk encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded request: %@",requestBody);
    
    NSError *theError = NULL;
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithJSONString:requestBody error:&theError];
    NSLog(@"Request Type: %@",[requestDictionary valueForKey:@"RequestType"]);
    
    Request* request = [Request init:requestDictionary];
    
    KPHRequestHandler* handler = [handlers objectForKey:[Request ASSOCIATE]];
    if(handler != nil){
        [handler handle:request];
    }
}
@end
