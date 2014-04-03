//
//  Request
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Request.h"

@implementation Request
+ (id)init: (NSDictionary*) requestDictionary
{
    return nil;
}
+ (NSString*) GET_LOGINS
{
    return @"get-logins";
}
+ (NSString*) GET_LOGINS_COUNT
{
    return @"get-logins-count";
}
+ (NSString*) GET_ALL_LOGINS
{
    return @"get-all-logins";
}
+ (NSString*) SET_LOGIN{
    return @"set-login";
}
+ (NSString*) ASSOCIATE{
    return @"associate";
}
+ (NSString*) TEST_ASSOCIATE{
    return @"test-associate";
}
+ (NSString*) GENERATE_PASSWORD{
    return @"generate-password";
}
@end
