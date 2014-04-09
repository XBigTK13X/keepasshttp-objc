//
//  KPHAppDelegate.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHAppDelegate.h"

static const int KEE_PASS_HTTP_PORT = 19455;

@implementation KPHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    httpServer = [[HTTPServer alloc] init];
    [httpServer setPort:KEE_PASS_HTTP_PORT];
	[httpServer setDocumentRoot:nil];
	[httpServer setConnectionClass:[KPHHttpConnection class]];
	
	NSError *error = nil;
	if(![httpServer start:&error])
	{
		NSLog(@"Error starting HTTP Server: %@", error);
	}
    else{
        NSLog(@"keypasshttp-objc server now running on port %i",KEE_PASS_HTTP_PORT);
    }
}

@end
