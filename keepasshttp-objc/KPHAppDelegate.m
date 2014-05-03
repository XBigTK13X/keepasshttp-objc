//
//  KPHAppDelegate.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#define LOGGING_LEVEL_TRACE 1;
#define LOGGING_LEVEL_INFO 1;
#define LOGGING_LEVEL_ERROR 1;
#define LOGGING_LEVEL_DEBUG 1;

#import "KPHAppDelegate.h"
#import "Logging.h"

@implementation KPHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    LogInfo(@"Running the example kph-objc server");
    self.kphServer = [KPHServer new];
    [self.kphServer startWithClient:[KPHKeePassClientMock new]];
}

@end
