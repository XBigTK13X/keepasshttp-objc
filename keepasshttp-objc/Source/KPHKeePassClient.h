//
//  KPHKeePassClient.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHTypes.h"
#import "KPHAes.h"
#import "KPHRequest.h"
#import "KPHGetLoginsUserResponse.h"
#import "KPHGeneratedPassword.h"

@protocol KPHKeePassClient
- (KPHPwGroup *) rootGroup;
- (KPHPwGroup *) recycleGroup;
- (void) saveEntry:(KPHPwEntry*)entry;

- (int) countMatchingEntries:(NSString*) url submitHost:(NSString*)submitHost realm:(NSString*)realm;
- (NSMutableArray*) findMatchingEntries:(NSString*) host submithost:(NSString*)submithost;
- (KPHPwEntry*) findEntryInAnyDatabase:(NSUUID*)uuid searchRecursive:(BOOL)searchRecursive;
- (KPHGeneratedPassword*) generatePassword;
- (NSArray*) getAllLogins;

- (NSDictionary*) getCustomConfig;
- (BOOL) getConfigBool:(NSString*)key;
- (void) setConfigBool:(NSString*) key enabled:(NSString*)enabled;

- (BOOL) promptUserForOverwrite: (NSString*)message title:(NSString*)title;
//Return nil if user declines
- (NSString*) promptUserForKeyName: (NSString*)keyMessage;
- (KPHGetLoginsUserResponse*) promptUserForAccess:(NSString*) message title:(NSString*)title host:(NSString*)host submithost:(NSString*)submithost entries:(NSArray*)entries;
- (BOOL) promptUserForEntryUpdate:(NSString*)message title:(NSString*)title;
- (void) showNotification:(NSString*)message;
- (void) updateUI;
@end
