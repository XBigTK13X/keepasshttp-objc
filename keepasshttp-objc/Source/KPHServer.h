//
//  KPHServer.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHLogging.h"
#import "KPHKeePassClient.h"
#import "HTTPServer.h"
#import "KPHHttpConnection.h"


@interface KPHServer : NSObject

@property (nonatomic) HTTPServer* httpServer;

- (void) startWithClient: (NSObject<KPHKeePassClient> *) keePassClient;
@end
