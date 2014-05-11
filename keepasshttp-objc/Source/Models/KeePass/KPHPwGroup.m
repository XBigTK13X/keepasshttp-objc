//
//  PwGroup.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/9/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHPwGroup.h"

@implementation KPHPwGroup
- (id) initWithParams:(BOOL)createNewUuid setTimes:(BOOL)setTimes name:(NSString*)name pwIcon:(NSString*) pwIcon
{
    self = [super init];
    if(self){
        self.Entries = [NSMutableDictionary new];
    }
    return self;
}
- (id) init
{
    return [self initWithUuid:[[NSUUID UUID] UUIDString]];
}
- (id) initWithUuid: (NSString*)uuid
{
    self = [super init];
    if(self){
        self.Uuid = [[NSUUID alloc] initWithUUIDString:uuid];
        self.Entries = [NSMutableDictionary new];
    }
    return self;
}
- (KPHPwEntry *) findEntry:(NSUUID*)uuid searchRecursive:(BOOL)searchRecursive
{
    return self.Entries[uuid];
}
- (void) addEntry:(KPHPwEntry*)entry takeOwnership:(BOOL)takeOwnership
{
    if(entry.Uuid != nil){
        self.Entries[entry.Uuid] = entry;
    }
}
- (KPHPwGroup *) findCreateGroup:(NSString*)name createIfNotFound:(BOOL)createIfNotFound
{
    return nil;
}
- (void) addGroup:(KPHPwGroup*)group takeOwnership:(BOOL)takeOwnership
{
    
}
@end
