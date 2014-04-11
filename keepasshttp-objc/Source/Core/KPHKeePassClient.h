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
- (NSArray*) findMatchingEntries:(Request*) request aes:(Aes*)aes;
@end
