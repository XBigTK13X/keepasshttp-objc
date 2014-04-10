//
//  KPHKeePassMockClient.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHKeePassClientMock.h"

@implementation KPHKeePassClientMock
{
    PwGroup* root;
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
