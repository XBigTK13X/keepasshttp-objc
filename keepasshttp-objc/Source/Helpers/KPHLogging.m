//
//  KPHLogging.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 5/3/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHLogging.h"

#import "DDASLLogger.h"
#import "DDTTYLogger.h"

int const ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation KPHLogging
+ (void) setup
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}
@end
