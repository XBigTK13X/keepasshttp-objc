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
        self->Key = [requestDictionary valueForKey:@"Key"];
        self->Id = [requestDictionary valueForKey:@"Id"];
        self->RequestType = [requestDictionary valueForKey:@"RequestType"];
        self->Verifier = [requestDictionary valueForKey:@"Verifier"];
        self->Nonce = [requestDictionary valueForKey:@"Nonce"];
        self->TriggerUnlock = [requestDictionary valueForKey:@"TriggerUnlock"];
    }
    return self;
}
@end
