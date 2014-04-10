//
//  KPHAppDelegate.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "KPHServer.h"
#import "KPHKeePassClientMock.h"

@interface KPHAppDelegate : NSObject <NSApplicationDelegate>

@property KPHServer* kphServer;
@property (assign) IBOutlet NSWindow *window;

@end
