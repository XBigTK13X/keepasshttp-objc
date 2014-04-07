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
    if (![KPHProtocol TestRequestVerifier:request key:request->Key])
        return;
    response->Id = request->Key;
    response->Success = true;
    [KPHProtocol SetResponseVerifier:request response:response];
}

@end
