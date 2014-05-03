//
//  Request
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHRequest.h"

@implementation KPHRequest
+ (BOOL) requiresEntriesInResponse: (NSString*)requestType
{
    return [requestType isEqual:@"get-logins"] || [requestType isEqual:@"get-all-logins"] || [requestType isEqual:@"generate-password"];
}
- (id)init: (NSDictionary*) requestDictionary
{
    self = [super init];
    if (self)
    {
        self.RequestType = requestDictionary[@"RequestType"];
        self.SortSelection = requestDictionary[@"SortSelection"];
        self.TriggerUnlock = requestDictionary[@"TriggerUnlock"];
        self.Login = requestDictionary[@"Login"];
        self.Password = requestDictionary[@"Password"];
        self.Uuid = requestDictionary[@"Uuid"];
        self.Url = requestDictionary[@"Url"];
        self.SubmitUrl = requestDictionary[@"SubmitUrl"];
        self.Key = requestDictionary[@"Key"];
        self.Id = requestDictionary[@"Id"];
        self.Verifier = requestDictionary[@"Verifier"];
        self.Nonce = requestDictionary[@"Nonce"];
        self.Realm = requestDictionary[@"Realm"];
    }
    return self;
}
@end
