//
//  KPHLogging.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 5/3/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

extern int const ddLogLevel;

@interface KPHLogging : NSObject
+ (void) setup;
@end
