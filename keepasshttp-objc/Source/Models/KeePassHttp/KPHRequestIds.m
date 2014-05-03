//
//  RequestIds.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/27/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHRequestIds.h"

@implementation KPHRequestIds
- (id) init
{
    self = [super init];
    if(self)
    {
        self.GET_LOGINS = @"get-logins";
        self.GET_LOGINS_COUNT = @"get-logins-count";
        self.GET_ALL_LOGINS = @"get-all-logins";
        self.SET_LOGIN = @"set-login";
        self.ASSOCIATE = @"associate";
        self.TEST_ASSOCIATE = @"test-associate";
        self.GENERATE_PASSWORD = @"generate-password";
    }
    return self;
}
@end
