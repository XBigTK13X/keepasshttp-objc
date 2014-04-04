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

+ (NSString* ) ToJSONString:(NSString *) rawString
{
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:rawString options:NSJSONWritingPrettyPrinted error:nil];
    return [SystemConvert ToUTF8String:jsonData];
}
@end
