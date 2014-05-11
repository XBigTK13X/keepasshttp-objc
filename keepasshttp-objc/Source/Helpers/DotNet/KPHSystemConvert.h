//
//  SystemConvert.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPHSystemConvert : NSObject
+ (NSString *) toBase64String: (NSData *) base64Data;
+ (NSData *) fromBase64String: (NSString *) base64String;
+ (NSString* ) toUTF8String: (NSData *) utf8Data;
+ (NSData *) fromUTF8String: (NSString *) utf8String;
+ (NSString* ) toJSON:(NSString *) key value:(NSString*)value;
+ (NSString* ) toJSONLast:(NSString *) key value:(NSString*)value;
@end
