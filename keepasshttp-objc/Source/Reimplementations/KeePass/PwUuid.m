//
//  PwUuid.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "PwUuid.h"

const u_int UuidSize = 16;

@implementation PwUuid
-(id) initWithUUID:(NSUUID*)uuid
{
    self = [super init];
    if(self)
    {
        self.Uuid = uuid;
    }
    return self;

}
-(id) initAndCreate:(BOOL) createNew
{
    self = [super init];
    if(self){
        if(createNew)
        {
            [self setUuid:[NSUUID UUID]];
        }
        else
        {
            [self setUuid:nil];
        }
    }
    return self;
}

- (void) SetZero
{
    
}
@end
