//
//  KPHKeePassClient.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeePassTypes.h"

@protocol KPHKeePassClient
- (PwGroup *) getRootGroup;
- (NSString *) getRecycleGroupUUID;
- (NSString *) getRootGroupUUID;
- (void) UpdateUI;
@end
