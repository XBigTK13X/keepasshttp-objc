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
- (void)processBodyData:(NSData *)postDataChunk
{
    NSString* requestBody = [SystemConvert ToUTF8String:postDataChunk];
    NSError *theError = NULL;
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithJSONString:requestBody error:&theError];
    
    NSLog(@"Decoded request: %@",requestBody);
    NSLog(@"Request Type: %@",[requestDictionary valueForKey:@"RequestType"]);
    
    Request* pluginRequest = [[Request alloc] init :requestDictionary];
    Response* handlerResponse = [Response new];
    
    if( [[Request ASSOCIATE] isEqualToString:[requestDictionary objectForKey:@"RequestType"]]){
        NSObject<KPHRequestHandler>* handler = [[KPHAssociationHandler alloc] init];
        [handler handle:pluginRequest response:handlerResponse];
    }
    
    NSString* responseBody = [SystemConvert ToBase64String:[handlerResponse toJson]];
    NSData* response = [responseBody dataUsingEncoding:NSUTF8StringEncoding];
    httpResponse =  [[HTTPDataResponse alloc] initWithData:response];
}
@end
