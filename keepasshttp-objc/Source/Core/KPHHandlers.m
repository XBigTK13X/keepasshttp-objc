//
//  KPHHandlers.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHHandlers.h"

@implementation KPHHandlers
- (id)init
{
    self = [super init];
    if(self){
        self.handlers = [NSMutableDictionary new];
        [self.handlers setObject:[KPHAssociateHandler new] forKey:@"associate"];
        [self.handlers setObject:[KPHTestAssociateHandler new] forKey:@"test-associate"];
        [self.handlers setObject:[KPHGetLoginsCountHandler new] forKey:@"get-logins-count"];
        [self.handlers setObject:[KPHGetLoginsHandler new] forKey:@"get-logins"];
        [self.handlers setObject:[KPHGetAllLoginsHandler new] forKey:@"get-all-logins"];
        [self.handlers setObject:[KPHSetLoginHandler new] forKey:@"set-login"];
        [self.handlers setObject:[KPHGeneratePasswordHandler new] forKey:@"generate-password"];
    }
    return self;
}

- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType
{
    return [self.handlers objectForKey:requestType];
}
@end
