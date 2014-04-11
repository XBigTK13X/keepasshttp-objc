//
//  Request
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "Request.h"

@implementation Request
+ (BOOL) requiresEntriesInResponse: (NSString*)requestType
{
    return [requestType isEqual:@"get-logins"] || [requestType isEqual:@"get-all-logins"] || [requestType isEqual:@"generate-password"];
}
- (id)init: (NSDictionary*) requestDictionary
{
    self = [super init];
    if (self)
    {
        self.Key = requestDictionary[@"Key"];
        self.Id = requestDictionary[@"Id"];
        self.RequestType = requestDictionary[@"RequestType"];
        self.Verifier = requestDictionary[@"Verifier"];
        self.Nonce = requestDictionary[@"Nonce"];
        self.TriggerUnlock = requestDictionary[@"TriggerUnlock"];
    }
    return self;
}
@end
