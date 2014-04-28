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

#import "KPHKeePassClient.h"
#import "KPHHandlers.h"

#import "SystemConvert.h"
#import "NSString+Hashes.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface KPHHttpConnection : HTTPConnection

@property (nonatomic) KPHHandlers* handlers;

+ (int) defaultPort;
@end
