//
//  KPHGlobalVars.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PwDefs.h"
@interface KPHGlobalVars : NSObject

@property (nonatomic) NSString* ASSOCIATE_KEY_PREFIX;
@property (nonatomic) int DEFAULT_NOTIFICATION_TIME;
@property (nonatomic) NSString* KEEPASSHTTP_NAME;
@property (nonatomic) NSString* KEEPASSHTTP_GROUP_NAME;
@property (nonatomic) int DEFAULT_PORT;
@property (nonatomic) NSString* HTTP_PREFIX;
@property (nonatomic) NSData* KEEPASSHTTP_UUID;
@property (nonatomic) PwDefs* PwDefs;

@end
