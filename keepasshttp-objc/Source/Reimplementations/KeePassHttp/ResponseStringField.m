//
//  ResponseStringField.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "ResponseStringField.h"

@implementation ResponseStringField
-(id) init: (NSString*) key value:(NSString*) value{
    self = [super init];
    if (self)
    {
        Key = key;
        Value = value;
    }
    return self;
}
@end
