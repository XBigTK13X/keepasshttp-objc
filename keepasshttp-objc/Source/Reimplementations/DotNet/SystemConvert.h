//
//  SystemConvert.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemConvert : NSObject
+ (NSString *) ToBase64String: (Byte *) inArray;
+ (Byte *) FromBase64String: (NSString *) inString;
@end
