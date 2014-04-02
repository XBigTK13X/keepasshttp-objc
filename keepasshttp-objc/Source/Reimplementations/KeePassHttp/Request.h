//
//  Request.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* Request_GET_LOGINS = @"get-logins";
NSString* Request_GET_LOGINS_COUNT = @"get-logins-count";
NSString* Request_GET_ALL_LOGINS = @"get-all-logins";
NSString* Request_SET_LOGIN = @"set-login";
NSString* Request_ASSOCIATE = @"associate";
NSString* Request_TEST_ASSOCIATE = @"test-associate";
NSString* Request_GENERATE_PASSWORD = @"generate-password";

@interface Request : NSObject{
    NSString * RequestType;
    NSString * SortSelection;
    NSString * TriggerUnlock;
    NSString * Login;
    NSString * Password;
    NSString * Uuid;
    NSString * Url;
    NSString * SubmitUrl;
    NSString * Key;
    NSString * Id;
    NSString * Verifier;
    NSString * Nonce;
    NSString * Realm;
}

@end
