//
//  KPHHandlers.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHHandlers.h"
#import "KPHUtil.h"
@implementation KPHHandlers
- (id)init
{
    self = [super init];
    if(self){
        self.handlers =
         @{
             [KPHUtil globalVars].RequestIds.ASSOCIATE:[KPHAssociateHandler new],
             [KPHUtil globalVars].RequestIds.TEST_ASSOCIATE:[KPHTestAssociateHandler new],
             [KPHUtil globalVars].RequestIds.GET_LOGINS_COUNT:[KPHGetLoginsCountHandler new],
             [KPHUtil globalVars].RequestIds.GET_ALL_LOGINS:[KPHGetAllLoginsHandler new],
             [KPHUtil globalVars].RequestIds.GET_LOGINS:[KPHGetLoginsHandler new],
             [KPHUtil globalVars].RequestIds.SET_LOGIN:[KPHSetLoginHandler new],
             [KPHUtil globalVars].RequestIds.GENERATE_PASSWORD:[KPHGeneratePasswordHandler new]
         };
    }
    return self;
}

- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType
{
    return self.handlers[requestType];
}
@end
