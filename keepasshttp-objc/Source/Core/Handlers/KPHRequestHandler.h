//
//  KPHRequestHandler.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/3/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "Response.h"
#import "Aes.h"

@protocol KPHRequestHandler
- (void) handle: (Request*)request response:(Response*)response;
@end
