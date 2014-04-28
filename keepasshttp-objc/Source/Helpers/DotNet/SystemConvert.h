//
//  SystemConvert.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemConvert : NSObject
+ (NSString *) ToBase64String: (NSData *) base64Data;
+ (NSData *) FromBase64String: (NSString *) base64String;
+ (NSString* ) ToUTF8String: (NSData *) utf8Data;
+ (NSData *) FromUTF8String: (NSString *) utf8String;
+ (NSString* ) ToJSON:(NSString *) key value:(NSString*)value;
+ (NSString* ) ToJSONLast:(NSString *) key value:(NSString*)value;
@end
