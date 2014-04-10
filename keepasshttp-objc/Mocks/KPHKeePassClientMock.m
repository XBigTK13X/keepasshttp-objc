//
//  KPHKeePassMockClient.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHKeePassClientMock.h"

@implementation KPHKeePassClientMock
-(id)init
{
    self = [super init];
    if(self){
        [self setRoot:[PwGroup new]];
        [self setRecycle:[PwGroup new]];
    }
    return self;
}

- (PwGroup*) rootGroup{
    return self.root;
}
- (PwGroup *) recycleGroup
{
    return self.recycle;
}
- (void) updateUI
{
    
}
- (BOOL) showOverwriteKeyConfirmation
{
    return true;
}
- (BOOL) showAssociationConfirmation
{
    return true;
}
@end
