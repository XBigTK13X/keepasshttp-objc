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
    [KPHLogging setup];
    if(keePassClient == nil){
        [NSException raise:@"Uninitialized KPHKeePassClient" format:@"keePassClient can not be nil."];
    }
    [KPHUtil setClient:keePassClient];
    [[KPHUtil client] setConfigOptions:[KPHUtil globalVars].ConfigOpt];
    
    self.httpServer = [[HTTPServer alloc] init];
    self.httpServer.port = [KPHUtil globalVars].ConfigOpt.ListenerPort;
    self.httpServer.documentRoot = nil;
    self.httpServer.connectionClass = [KPHHttpConnection class];
    
    NSError *error = nil;
    if(![self.httpServer start:&error])
    {
        DDLogError(@"Error starting keepasshttp-objc server: %@", error);
    }
    else{
        DDLogInfo(@"keypasshttp-objc server now running on port %li",(long)[KPHUtil globalVars].ConfigOpt.ListenerPort);
    }
}
@end
