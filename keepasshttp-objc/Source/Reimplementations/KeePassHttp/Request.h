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
+ (BOOL) requiresEntriesInResponse: (NSString*)requestType;
- (id) init: (NSDictionary*)requestDictionary;
@end
