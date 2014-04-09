//
//  MacPass.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "MacPass.h"

@implementation MacPass
{
    PwGroup* root;
}

+ (MacPass *)instance
{
    static MacPass *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [MacPass new];
            sharedSingleton->root = [PwGroup new];
        }
        
        return sharedSingleton;
    }
}
- (PwGroup*) getRootGroup{
    return root;
}
- (NSString *) getRecycleGroupUUID
{
    return @"2548-bsdf-2345-gsdf-3242";
}
- (NSString *) getRootGroupUUID
{
    return @"0384-2548-bsdf-2345-gsdf";
}
- (void) UpdateUI
{
    
}
@end
