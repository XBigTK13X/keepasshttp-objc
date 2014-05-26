//
//  KPHKeePassMockClient.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHLogging.h"
#import "KPHKeePassClientMock.h"
#import "KPHUtil.h"

@implementation KPHKeePassClientMock

-(void) setConfigOptions:(KPHConfigOpt*)configOpt
{
}

-(id)init
{
    self = [super init];
    if(self){
        self.root = [KPHPwGroup new];
        self.recycle = [KPHPwGroup new];
        
        self.validEntry = [KPHPwEntry new];
        self.validEntry.Strings[[KPHUtil globalVars].PwDefs.UserNameField] = @"keepasshttpobjc";
        self.validEntry.Strings[[KPHUtil globalVars].PwDefs.PasswordField] = @"KeePass1";
        self.validEntry.Strings[[KPHUtil globalVars].PwDefs.UrlField] = @"reddit.com";
        self.knownHost = @"reddit";
        
        [self.root addEntry:self.validEntry takeOwnership:true];
        
    }
    DDLogInfo(@"Running the kph-objc mock server");
    return self;
}

- (KPHPwGroup*) rootGroup{
    return self.root;
}
- (KPHPwGroup *) recycleGroup
{
    return self.recycle;
}
- (void) refreshUI
{
    
}
- (BOOL) promptUserForOverwrite: (NSString*)message title:(NSString*)title
{
    DDLogVerbose(@"%@ - %@",message,title);
    DDLogVerbose(@"Replying: true");
    return true;
}
- (NSString*) promptUserForKeyName: (NSString*)keyMessage
{
    DDLogVerbose(@"%@:",keyMessage);
    DDLogVerbose(@"Replying: keepasshttp-objc mock");
    return @"keepasshttp-objc mock";
}
- (int)countMatchingEntries:(NSString*) url submitHost:(NSString*)submitHost realm:(NSString*)realm
{
    DDLogVerbose(@"Counting matching entries");
    if([url rangeOfString:self.knownHost].location == NSNotFound && [submitHost rangeOfString:self.knownHost].location == NSNotFound  && [realm rangeOfString:self.knownHost].location == NSNotFound)
    {
        DDLogVerbose(@"None found for %@",url);
        return 0;
    }
    DDLogVerbose(@"Found 1");
    return 1;
}
- (NSMutableArray*) findMatchingEntries:(NSString*) host submithost:(NSString*)submithost
{
    if([host rangeOfString:self.knownHost].location == NSNotFound && [submithost rangeOfString:self.knownHost].location == NSNotFound)
    {
        return nil;
    }    
    NSMutableArray* entries = [NSMutableArray new];
    [entries addObject:self.validEntry];
    return entries;
}

- (void) showNotification:(NSString*)message
{
    DDLogVerbose(@"Notification displayed: %@",message);
}
- (KPHPwEntry*) findEntryInAnyDatabase:(NSUUID*)uuid searchRecursive:(BOOL)searchRecursive
{
    return self.root.Entries[uuid];
}
- (KPHGeneratedPassword*) generatePassword
{
    DDLogVerbose(@"Generating a password");
    KPHGeneratedPassword* generated = [KPHGeneratedPassword new];
    generated.Password = @"KeePassGenerated1";
    generated.BitLength = 75;
    return generated;
}

- (KPHGetLoginsUserResponse*) promptUserForAccess:(NSString*) message title:(NSString*)title host:(NSString*)host submithost:(NSString*)submithost entries:(NSArray*)entries
{
    DDLogVerbose(@"Prompting for access: %@ - %@",title,message);
    KPHGetLoginsUserResponse* response = [KPHGetLoginsUserResponse new];
    response.Accept = true;
    return response;
}
- (BOOL) promptUserForEntryUpdate:(NSString*)message title:(NSString*)title
{
    DDLogVerbose(@"Prompting for entry update: %@ - %@",title,message);
    return true;
}

- (void) createOrUpdateEntry:(KPHPwEntry*)entry
{
    DDLogVerbose(@"Saving an entry");
    [self.root addEntry:entry takeOwnership:true];
}

- (void) createOrUpdateGroup:(KPHPwGroup*)group
{
    
}

- (KPHPwGroup*) findGroup:(NSString*) name{
    return self.root;
}

- (NSArray*) getAllLogins
{
    NSMutableArray* entries = [NSMutableArray new];
    [entries addObject:self.validEntry];
    return entries;
}
@end
