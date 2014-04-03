//
//  SPSHttpConnection.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "HTTPConnection.h"
#import "HTTPDataResponse.h"
#import "CJSONDeserializer.h"
#import "NSDictionary_JSONExtensions.h"

#import "KPHRequestHandler.h"
#import "KPHAssociationHandler.h"

@interface KPHHttpConnection : HTTPConnection
{
    NSMutableDictionary* handlers;
}

@end
