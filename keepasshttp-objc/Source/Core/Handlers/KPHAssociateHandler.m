//
//  SPSAssociationHandler.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHAssociateHandler.h"

@implementation KPHAssociateHandler

- (void) handle: (Request*)request response:(Response*)response;
{
    NSLog(@"Handling request - associate");
    if (![KPHProtocol TestRequestVerifier:request key:request->Key])
        return;
    NSLog(@"Ready to associate");
    response->Id = request->Key;
    response->Success = true;
    [KPHProtocol SetResponseVerifier:request response:response];
}

- (void) TestAssociateHandler: (Request*) request response:(Response*) response
{
    if (![KPHProtocol VerifyRequest:request])
        return;
    
    response->Success = true;
    response->Id = request->Id;
    [KPHProtocol SetResponseVerifier:request response:response];
}

@end
