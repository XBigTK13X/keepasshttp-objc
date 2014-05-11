//
//  KPHConfigOpt.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/15/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHConfigOpt.h"

@implementation KPHConfigOpt
- (id) initWithCustomConfig:(NSDictionary*)customConfig
{
    return [self init];
}
- (id)init
{
    self = [super init];
    if(self)
    {
        self.ReceiveCredentialNotification = true;
        self.SpecificMatchingOnly = true;
        self.UnlockDatabaseRequest = true;
        self.AlwaysAllowAccess = false;
        self.AlwaysAllowUpdates = false;
        self.SearchInAllOpenedDatabases = true;
        self.MatchSchemes = false;
        self.ReturnStringFields = false;
        self.SortResultByUsername = false;
        self.ListenerPort = 19455;
    }
    return self;
    
}

@end
