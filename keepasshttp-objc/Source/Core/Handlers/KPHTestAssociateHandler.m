//
//  KPHTestAssociateHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHTestAssociateHandler.h"

@implementation KPHTestAssociateHandler
- (void) handle: (Request*)request response:(Response*)response;
{
    if (![KPHProtocol VerifyRequest:request])
        return;
    
    response->Success = true;
    response->Id = request->Id;
    [KPHProtocol SetResponseVerifier:request response:response];
}
@end
