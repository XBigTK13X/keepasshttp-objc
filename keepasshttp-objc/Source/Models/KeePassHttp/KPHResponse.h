//
//  Response.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHRequest.h"
#import "KPHResponseEntry.h"
#import "AssemblyInfo.h"
#import "CJSONSerializer.h"
#import "SystemConvert.h"

@interface KPHResponse : NSObject<NSObject>

@property (nonatomic) NSString* RequestType;
@property (nonatomic) NSString* Error;
@property (nonatomic) BOOL Success;
@property (nonatomic) NSString* Id;
@property (nonatomic) NSUInteger Count;
@property (nonatomic) NSString* Version;
@property (nonatomic) NSString* Hash;
@property (nonatomic) NSMutableArray* Entries;
@property (nonatomic) NSString* Nonce;
@property (nonatomic) NSString* Verifier;

- (id)init: (NSString *) requestType  hash:(NSString*) hash;
- (NSString*) toJson;
@end
