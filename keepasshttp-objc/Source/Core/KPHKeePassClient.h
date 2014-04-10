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
- (PwGroup *) rootGroup;
- (PwGroup *) recycleGroup;
- (void) updateUI;
- (BOOL) showOverwriteKeyConfirmation;
- (BOOL) showAssociationConfirmation;
@end
