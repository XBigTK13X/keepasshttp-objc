//
//  Request.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (nonatomic) NSString * RequestType;
@property (nonatomic) NSString * SortSelection;
@property (nonatomic) NSString * TriggerUnlock;
@property (nonatomic) NSString * Login;
@property (nonatomic) NSString * Password;
@property (nonatomic) NSString * Uuid;
@property (nonatomic) NSString * Url;
@property (nonatomic) NSString * SubmitUrl;
@property (nonatomic) NSString * Key;
@property (nonatomic) NSString * Id;
@property (nonatomic) NSString * Verifier;
@property (nonatomic) NSString * Nonce;
@property (nonatomic) NSString * Realm;

+ (BOOL) requiresEntriesInResponse: (NSString*)requestType;
- (id) init: (NSDictionary*)requestDictionary;
@end
