//
//  SystemConvert.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHSystemConvert.h"

@implementation KPHSystemConvert
+ (NSString *) toBase64String: (NSData *) base64Data
{
    return [base64Data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (NSData *) fromBase64String: (NSString *) base64String
{
    return [[NSData alloc] initWithBase64EncodedString:base64String options:0];
}
+ (NSString* ) toUTF8String: (NSData *) utf8Data
{
    return [[NSString alloc] initWithData:utf8Data encoding:NSUTF8StringEncoding];
}
+ (NSData *) fromUTF8String: (NSString *) utf8String
{
    return [utf8String dataUsingEncoding:NSUTF8StringEncoding];
}
+ (NSString*) toJSONLast:(NSString *) key value:(NSString*)value
{
    return [NSString stringWithFormat:@"\"%@\":\"%@\"",key,value];
}

+ (NSString* ) toJSON:(NSString *) key value:(NSString*)value
{
    return [NSString stringWithFormat:@"%@,",[KPHSystemConvert toJSONLast:key value:value]];
}
@end
