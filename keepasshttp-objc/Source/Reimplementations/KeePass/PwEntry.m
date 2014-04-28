//
//  PwEntry.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "PwEntry.h"

@implementation PwEntry
- (id) initWithUuid:(NSUUID*)uuid
{
    self = [super init];
    if(self){
        self.Uuid = [[PwUuid alloc]initWithUUID:uuid];
        self.Strings = [NSMutableDictionary new];
    }
    return self;
}
- (id) init:(BOOL) createNewUuid setTimes:(BOOL) setTimes
{
    self = [super init];
    if(self)
    {
        if(createNewUuid)
        {
            self.Uuid = [[PwUuid alloc] initAndCreate:true];
        }
        
        if(setTimes)
        {
            NSDate* currentTime = [NSDate date];
            
            self.m_tCreation = self.m_tLastMod = self.m_tLastAccess = self.m_tParentGroupLastMod = currentTime;
        }
        self.Strings = [NSMutableDictionary new];
    }
    return self;
}
- (NSString* ) getString: (NSString * )lookup{
    return self.Strings[lookup];
}
- (void) Touch:(BOOL)modified touchParents:(BOOL)touchParents
{
    
}
- (void) Touch:(BOOL)modifed
{
    
}
@end
