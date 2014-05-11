//
//  KPHConfigOpt.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/15/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPHConfigOpt : NSObject
@property (nonatomic) BOOL ReceiveCredentialNotification;
@property (nonatomic) BOOL SpecificMatchingOnly;
@property (nonatomic) BOOL UnlockDatabaseRequest;
@property (nonatomic) BOOL AlwaysAllowAccess;
@property (nonatomic) BOOL AlwaysAllowUpdates;
@property (nonatomic) BOOL SearchInAllOpenedDatabases;
@property (nonatomic) BOOL MatchSchemes;
@property (nonatomic) BOOL ReturnStringFields;
@property (nonatomic) BOOL SortResultByUsername;
@property (nonatomic) NSInteger ListenerPort;
@end
