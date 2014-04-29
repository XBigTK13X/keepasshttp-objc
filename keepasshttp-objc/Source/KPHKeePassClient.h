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
#import "KPHGetLoginsUserResponse.h"
#import "KPHGeneratedPassword.h"

@protocol KPHKeePassClient
- (PwGroup *) rootGroup;
- (PwGroup *) recycleGroup;
- (void) updateUI;
- (int) countMatchingEntries:(NSString*) url submitHost:(NSString*)submitHost realm:(NSString*)realm;
- (NSMutableArray*) findMatchingEntries:(Request*) request aes:(Aes*)aes;
- (BOOL) getConfigBool:(NSString*)key;
- (void) setConfigBool:(NSString*) key enabled:(NSString*)enabled;
- (void) showNotification:(NSString*)message;
- (NSDictionary*) getCustomConfig;
- (PwEntry*) findEntryInAnyDatabase:(NSUUID*)uuid searchRecursive:(BOOL)searchRecursive;
- (KPHGeneratedPassword*) generatePassword;

- (BOOL) promptUserForOverwrite: (NSString*)message title:(NSString*)title;
//Return nil if user declines
- (NSString*) promptUserForKeyName: (NSString*)keyMessage;
- (KPHGetLoginsUserResponse*) promptUserForAccess:(NSString*) message title:(NSString*)title host:(NSString*)host submithost:(NSString*)submithost entries:(NSArray*)entries;
- (BOOL) promptUserForEntryUpdate:(NSString*)message title:(NSString*)title;
@end
