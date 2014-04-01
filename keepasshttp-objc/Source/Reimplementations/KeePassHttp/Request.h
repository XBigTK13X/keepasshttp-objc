//
//  Request.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

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
