//
//  KPHConfigOpt.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/15/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHConfigOpt.h"
#import "KPHUtil.h"

@implementation KPHConfigOpt
- (id)init
{
    self = [super init];
    if(self)
    {
        self.ReceiveCredentialNotification = @"KeePassHttp_ReceiveCredentialNotification";
        self.SpecificMatchingOnly = @"KeePassHttp_SpecificMatchingOnly";
        self.UnlockDatabaseRequest = @"KeePassHttp_UnlockDatabaseRequest";
        self.AlwaysAllowAccess = @"KeePassHttp_AlwaysAllowAccess";
        self.AlwaysAllowUpdates = @"KeePassHttp_AlwaysAllowUpdates";
        self.SearchInAllOpenedDatabases = @"KeePassHttp_SearchInAllOpenedDatabases";
        self.MatchSchemes = @"KeePassHttp_MatchSchemes";
        self.ReturnStringFields = @"KeePassHttp_ReturnStringFields";
        self.SortResultByUsername = @"KeePassHttp_SortResultByUsername";
        self.ListenerPort = @"KeePassHttp_ListenerPort";
    }
    return self;
    
}
- (BOOL) get:(NSString*)key
{
    return [[KPHUtil client] getConfigBool:key];
}
- (void) set:(NSString*) key enabled:(NSString*)enabled
{
    [[KPHUtil client] setConfigBool:key enabled:enabled];
}
@end
