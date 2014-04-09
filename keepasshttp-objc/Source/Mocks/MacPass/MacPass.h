//
//  MacPass.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeePassTypes.h"

@interface MacPass : NSObject
+ (MacPass *)instance;
- (PwGroup *) getRootGroup;
- (NSString *) getRecycleGroupUUID;
- (NSString *) getRootGroupUUID;
- (void) UpdateUI;
@end
