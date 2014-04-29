//
//  KPHKeePassMockClient.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHKeePassClientMock.h"
#import "KPHUtil.h"

@implementation KPHKeePassClientMock
-(id)init
{
    self = [super init];
    if(self){
        self.root = [PwGroup new];
        self.recycle = [PwGroup new];
        NSLog(@"Running the kph-objc mock server");
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
- (BOOL) promptUserForOverwrite: (NSString*)message title:(NSString*)title
{
    NSLog(@"Asking user if its okay to overwrite: %@ - %@",message,title);
    return true;
}
- (NSString*) promptUserForKeyName: (NSString*)keyMessage
{
    NSLog(@"Prompting for key name: %@:",keyMessage);
    return @"keepasshttp-objc mock";
}
- (int)countMatchingEntries:(NSString*) url submitHost:(NSString*)submitHost realm:(NSString*)realm
{
    return 1;
}
- (NSArray*) findMatchingEntries:(Request*) request aes:(Aes*)aes
{
    NSMutableArray* entries = [NSMutableArray new];
    return entries;
}

- (BOOL) getConfigBool:(NSString*)key
{
    NSLog(@"Grabbing config for %@",key);
    return false;
}
- (void) setConfigBool:(NSString*) key enabled:(NSString*)enabled
{
    
}
- (void) showNotification:(NSString*)message
{
    NSLog(@"Notification displayed: %@",message);
}
- (NSDictionary*) getCustomConfig
{
    NSDictionary* config = [NSMutableDictionary new];
    return config;
}
- (PwEntry*) findEntryInAnyDatabase:(NSUUID*)uuid searchRecursive:(BOOL)searchRecursive
{
    PwEntry* entry = [PwEntry new];
    return entry;
}
- (KPHGeneratedPassword*) generatePassword
{
    KPHGeneratedPassword* generated = [KPHGeneratedPassword new];
    return generated;
}

- (KPHGetLoginsUserResponse*) promptUserForAccess:(NSString*) message title:(NSString*)title host:(NSString*)host submithost:(NSString*)submithost entries:(NSArray*)entries
{
    NSLog(@"Prompting for access: %@ - %@",title,message);
    KPHGetLoginsUserResponse* response = [KPHGetLoginsUserResponse new];
    return response;
}
- (BOOL) promptUserForEntryUpdate:(NSString*)message title:(NSString*)title
{
    NSLog(@"Prompting for entry update: %@ - %@",title,message);
    return true;
}
@end
