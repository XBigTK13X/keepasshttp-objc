//
//  PwGroup.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/9/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KPHPwEntry.h"

@interface KPHPwGroup : NSObject

@property (nonatomic) NSUUID* Uuid;
@property (nonatomic) NSMutableDictionary* Entries;

- (id) initWithParams:(BOOL)createNewUuid setTimes:(BOOL)setTimes name:(NSString*)name pwIcon:(NSString*) pwIcon;
- (KPHPwEntry *) findEntry:(NSUUID*)uuid searchRecursive:(BOOL)searchRecursive;
- (void) addEntry:(KPHPwEntry*)entry takeOwnership:(BOOL)takeOwnership;
- (KPHPwGroup *) findCreateGroup:(NSString*)name createIfNotFound:(BOOL)createIfNotFound;
- (void) addGroup:(KPHPwGroup*)group takeOwnership:(BOOL)takeOwnership;
@end
