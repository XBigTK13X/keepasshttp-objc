//
//  SPSKeePassUtil.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PwEntry.h"

@interface KPHKeePassUtil : NSObject
+ (PwEntry *) GetConfigEntry : (BOOL) access;
@end
