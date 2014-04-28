//
//  RequestIds.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/27/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestIds : NSObject
@property (nonatomic) NSString* GET_LOGINS;
@property (nonatomic) NSString* GET_LOGINS_COUNT;
@property (nonatomic) NSString* GET_ALL_LOGINS;
@property (nonatomic) NSString* SET_LOGIN;
@property (nonatomic) NSString* ASSOCIATE;
@property (nonatomic) NSString* TEST_ASSOCIATE;
@property (nonatomic) NSString* GENERATE_PASSWORD;
@end
