//
//  KPHRequestHandler.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/3/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHProtocol.h"
#import "KPHRequest.h"
#import "KPHResponse.h"
#import "Aes.h"
#import "KPHConfigOpt.h"

@protocol KPHRequestHandler
- (void) handle: (KPHRequest*)request response:(KPHResponse*)response aes:(Aes*)aes;
@end