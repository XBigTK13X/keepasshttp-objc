//
//  PwEntry.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHPwEntry.h"

@implementation KPHPwEntry
- (id) init
{
    self = [super init];
    if(self){
        self = [self initWithUuid:[NSUUID UUID]];
    }
    return self;
}
- (id) initWithUuid:(NSUUID*)uuid
{
    self = [super init];
    if(self){
        self.Uuid = uuid;
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
            self.Uuid = [NSUUID UUID];
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
@end
