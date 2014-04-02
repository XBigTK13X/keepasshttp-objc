//
//  Request.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject{
    @public NSString * RequestType;
    @public NSString * SortSelection;
    @public NSString * TriggerUnlock;
    @public NSString * Login;
    @public NSString * Password;
    @public NSString * Uuid;
    @public NSString * Url;
    @public NSString * SubmitUrl;
    @public NSString * Key;
    @public NSString * Id;
    @public NSString * Verifier;
    @public NSString * Nonce;
    @public NSString * Realm;
}
+ (NSString*) GET_LOGINS;
+ (NSString*) GET_LOGINS_COUNT;
+ (NSString*) GET_ALL_LOGINS;
+ (NSString*) SET_LOGIN;
+ (NSString*) ASSOCIATE;
+ (NSString*) TEST_ASSOCIATE;
+ (NSString*) GENERATE_PASSWORD;
@end
