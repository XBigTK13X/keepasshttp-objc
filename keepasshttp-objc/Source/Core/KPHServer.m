//
//  KPHServer.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHServer.h"

@implementation KPHServer
- (void) startWithClient: (NSObject<KPHKeePassClient> *) keePassClient
{
    [self startWithClientOnPort:keePassClient port:[KPHHttpConnection defaultPort]];
}
- (void) startWithClientOnPort: (NSObject<KPHKeePassClient> *) keePassClient port:(int)port
{
    [KPHUtil setClient:keePassClient];
    
    [self setHttpServer:[[HTTPServer alloc] init]];
    [self.httpServer setPort:port];
    [self.httpServer setDocumentRoot:nil];
    [self.httpServer setConnectionClass:[KPHHttpConnection class]];
    
    NSError *error = nil;
    if(![self.httpServer start:&error])
    {
        NSLog(@"Error starting keepasshttp-objc server: %@", error);
    }
    else{
        NSLog(@"keypasshttp-objc server now running on port %i",port);
    }
}
@end
