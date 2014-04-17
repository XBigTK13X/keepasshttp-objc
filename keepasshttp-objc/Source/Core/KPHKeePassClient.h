//
//  KPHKeePassClient.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeePassTypes.h"
#import "Aes.h"
#import "Request.h"

@protocol KPHKeePassClient
- (PwGroup *) rootGroup;
- (PwGroup *) recycleGroup;
- (void) updateUI;
- (BOOL) promptUserForOverwrite;
//Return nil if user declines
- (NSString*) promptUserForKeyName;
- (int) countMatchingEntries:(NSString*) url submitHost:(NSString*)submitHost realm:(NSString*)realm;
- (NSMutableArray*) findMatchingEntries:(Request*) request aes:(Aes*)aes;
- (BOOL) getConfigBool:(NSString*)key;
- (void) setConfigBool:(NSString*) key enabled:(NSString*)enabled;
- (KPHGetLoginsUserResponse*) promptUserForAccess:(NSString*)host submithost:(NSString*)submithost entries:(NSArray*)entries;
@end
