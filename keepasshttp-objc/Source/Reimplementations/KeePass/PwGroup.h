//
//  PwGroup.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/9/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PwEntry.h"
#import "PwUuid.h"

@interface PwGroup : NSObject

@property (nonatomic) NSUUID* Uuid;

- (PwEntry *) findEntry:(PwUuid*)uuid searchRecursive:(BOOL)searchRecursive;
- (void) addEntry:(PwEntry*)entry takeOwnership:(BOOL)takeOwnership;
@end
