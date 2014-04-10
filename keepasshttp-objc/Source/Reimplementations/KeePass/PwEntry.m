//
//  PwEntry.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "PwEntry.h"

@implementation PwEntry
- (id) init:(BOOL) createNewUuid setTimes:(BOOL) setTimes
{
    self = [super init];
    if(self)
    {
        if(createNewUuid)
        {
            [self setUuid:[[PwUuid alloc] initAndCreate:true]];
        }
        
        if(setTimes)
        {
            NSDate* currentTime = [NSDate date];
            
            [self setM_tCreation:currentTime];
            [self setM_tLastMod:currentTime];
            [self setM_tLastAccess:currentTime];
            [self setM_tParentGroupLastMod:currentTime];
        }
    }
    return self;
}
- (NSString* ) getString: (NSString * )lookup{
    return nil;
}
@end
