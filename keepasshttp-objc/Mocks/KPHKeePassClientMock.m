//
//  KPHKeePassMockClient.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHKeePassClientMock.h"

@implementation KPHKeePassClientMock
-(id)init
{
    self = [super init];
    if(self){
        [self setRoot:[PwGroup new]];
        [self setRecycle:[PwGroup new]];
    }
    return self;
}

- (PwGroup*) rootGroup{
    return self.root;
}
- (PwGroup *) recycleGroup
{
    return self.recycle;
}
- (void) updateUI
{
    
}
- (BOOL) promptUserForOverwrite
{
    return true;
}
- (NSString*) promptUserForKeyName
{
    return @"keepasshttp-objc mock";
}
- (int)countMatchingEntries:(NSString*) url submitHost:(NSString*)submitHost realm:(NSString*)realm
{
    return 1;
}
- (NSArray*) findMatchingEntries:(Request*) request aes:(Aes*)aes
{
    return nil;
}

- (BOOL) getConfigBool:(NSString*)key
{
    return false;
}
- (void) setConfigBool:(NSString*) key enabled:(NSString*)enabled
{
    
}
- (void) showNotification:(NSString*)message
{
    
}
- (NSDictionary*) getCustomConfig
{
    return nil;
}
- (PwEntry*) findEntryInAnyDatabase:(PwUuid*)uuid searchRecursive:(BOOL)searchRecursive
{
    return nil;
}
- (KPHGeneratedPassword*) generatePassword
{
    return nil;
}

- (BOOL) promptUserForOverwrite: (NSString*)message title:(NSString*)title
{
    return true;
}
//Return nil if user declines
- (NSString*) promptUserForKeyName: (NSString*)keyMessage
{
    return @"KPH Mock Client";
}
- (KPHGetLoginsUserResponse*) promptUserForAccess:(NSString*) message title:(NSString*)title host:(NSString*)host submithost:(NSString*)submithost entries:(NSArray*)entries
{
    return nil;
}
- (BOOL) promptUserForEntryUpdate:(NSString*)message title:(NSString*)title
{
    return true;
}
@end
