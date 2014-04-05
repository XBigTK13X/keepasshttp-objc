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

#import "KPHHandlers.h"

#import "SystemConvert.h"

@interface KPHHttpConnection : HTTPConnection
{
    KPHHandlers* handlers;
}
@end
