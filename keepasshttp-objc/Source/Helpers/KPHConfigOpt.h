//
//  KPHConfigOpt.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/15/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHKeePassClient.h"

@interface KPHConfigOpt : NSObject
@property (nonatomic) NSString* ReceiveCredentialNotification;
@property (nonatomic) NSString* SpecificMatchingOnly;
@property (nonatomic) NSString* UnlockDatabaseRequest;
@property (nonatomic) NSString* AlwaysAllowAccess;
@property (nonatomic) NSString* AlwaysAllowUpdates;
@property (nonatomic) NSString* SearchInAllOpenedDatabases;
@property (nonatomic) NSString* MatchSchemes;
@property (nonatomic) NSString* ReturnStringFields;
@property (nonatomic) NSString* SortResultByUsername;
@property (nonatomic) NSString* ListenerPort;

- (id) initWithCustomConfig:(NSDictionary*)customConfig;
- (BOOL) get:(NSString*)key;
- (void) set:(NSString*) key enabled:(NSString*)enabled;
@end
