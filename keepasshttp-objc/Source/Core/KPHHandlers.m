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
        handlers = [NSMutableDictionary new];
        [handlers setObject:[KPHAssociateHandler new] forKey:@"associate"];
        [handlers setObject:[KPHTestAssociateHandler new] forKey:@"test-associate"];
        [handlers setObject:[KPHGetLoginsCountHandler new] forKey:@"get-logins-count"];
        [handlers setObject:[KPHGetLoginsHandler new] forKey:@"get-logins"];
        [handlers setObject:[KPHGetAllLoginsHandler new] forKey:@"get-all-logins"];
        [handlers setObject:[KPHSetLoginHandler new] forKey:@"set-login"];
        [handlers setObject:[KPHGeneratePasswordHandler new] forKey:@"generate-password"];
    }
    return self;
}

- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType
{
    return [handlers objectForKey:requestType];
}
@end
