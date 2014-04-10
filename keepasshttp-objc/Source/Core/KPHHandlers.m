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
        self.handlers =
         @{
             @"associate":[KPHAssociateHandler new],
             @"test-associate":[KPHTestAssociateHandler new],
             @"get-logins-count":[KPHGetLoginsCountHandler new],
             @"get-all-logins":[KPHGetAllLoginsHandler new],
             @"get-logins":[KPHGetLoginsHandler new],
             @"set-login":[KPHSetLoginHandler new],
             @"generate-password":[KPHGeneratePasswordHandler new]
             
         };
    }
    return self;
}

- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType
{
    return self.handlers[requestType];
}
@end
