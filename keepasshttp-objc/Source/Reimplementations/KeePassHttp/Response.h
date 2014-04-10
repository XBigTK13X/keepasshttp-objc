//
//  Response.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "ResponseEntry.h"
#import "AssemblyInfo.h"
#import "CJSONSerializer.h"
#import "SystemConvert.h"

@interface Response : NSObject<NSObject>

@property (nonatomic) NSString* RequestType;
@property (nonatomic) NSString* Error;
@property (nonatomic) BOOL Success;
@property (nonatomic) NSString* Id;
@property (nonatomic) int Count;
@property (nonatomic) NSString* Version;
@property (nonatomic) NSString* Hash;
@property (nonatomic) NSArray* Entries;
@property (nonatomic) NSString* Nonce;
@property (nonatomic) NSString* Verifier;

- (id)init: (NSString *) requestType  hash:(NSString*) hash;
- (NSString*) toJson;
@end
