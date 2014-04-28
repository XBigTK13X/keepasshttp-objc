//
//  PwGroup.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/9/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "PwGroup.h"

@implementation PwGroup
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
- (PwEntry *) findEntry:(PwUuid*)uuid searchRecursive:(BOOL)searchRecursive
{
    return self.Entries[[uuid.Uuid UUIDString]];
}
- (void) addEntry:(PwEntry*)entry takeOwnership:(BOOL)takeOwnership
{
    NSLog(@"%@,%@,%@",entry,entry.Uuid,entry.Uuid.Uuid);
    self.Entries[entry.Uuid.Uuid] = entry;
}
- (void) searchEntries:(SearchParameters*)params entries:(NSMutableArray*)entries
{
    
}
- (PwGroup *) findCreateGroup:(NSString*)name createIfNotFound:(BOOL)createIfNotFound
{
    return nil;
}
- (void) AddGroup:(PwGroup*)group takeOwnership:(BOOL)takeOwnership
{
    
}
@end
