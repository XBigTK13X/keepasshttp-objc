//
//  PwGroup.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/9/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "PwGroup.h"

@implementation PwGroup
- (id) init
{
    return [self initWithUuid:[[NSUUID UUID] UUIDString]];
}
- (id) initWithUuid: (NSString*)uuid
{
    self = [super init];
    if(self){
        self.Uuid = [[NSUUID alloc] initWithUUIDString:uuid];
    }
    return self;
}
- (PwEntry *) findEntry:(PwUuid*)uuid searchRecursive:(BOOL)searchRecursive
{
    return nil;
}
- (void) addEntry:(PwEntry*)entry takeOwnership:(BOOL)takeOwnership
{
    
}
@end
