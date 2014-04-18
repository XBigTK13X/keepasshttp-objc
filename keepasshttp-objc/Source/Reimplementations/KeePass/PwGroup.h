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
#import "SearchParameters.h"

@interface PwGroup : NSObject

@property (nonatomic) NSUUID* Uuid;

- (PwEntry *) findEntry:(PwUuid*)uuid searchRecursive:(BOOL)searchRecursive;
- (void) addEntry:(PwEntry*)entry takeOwnership:(BOOL)takeOwnership;
- (void) searchEntries:(SearchParameters*)params entries:(NSMutableArray*)entries;
@end
