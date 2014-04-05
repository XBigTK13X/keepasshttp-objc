//
//  SystemConvert.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "SystemConvert.h"

@implementation SystemConvert
+ (NSString *) ToBase64String: (NSData *) base64Data
{
    return [base64Data base64EncodedStringWithOptions:0];
}
+ (NSData *) FromBase64String: (NSString *) base64String
{
    return [[NSData alloc] initWithBase64EncodedString:base64String options:0];
}
+ (NSString* ) ToUTF8String: (NSData *) utf8Data
{
    return [[NSString alloc] initWithData:utf8Data encoding:NSUTF8StringEncoding];
}

+ (NSString*) ToJSONLast:(NSString *) key value:(NSString*)value
{
    return [NSString stringWithFormat:@"\"%@\":\"%@\"",key,value];
}

+ (NSString* ) ToJSON:(NSString *) key value:(NSString*)value
{
    return [NSString stringWithFormat:@"%@,",[SystemConvert ToJSONLast:key value:value]];
}
@end
