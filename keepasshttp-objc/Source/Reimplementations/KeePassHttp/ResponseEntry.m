//
//  ResponseEntry.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "ResponseEntry.h"

@implementation ResponseEntry
-(id) init:(NSString *) name login:(NSString *) login password:(NSString *) password uuid:(NSString *) uuid stringFields:(NSArray *) stringFields
{
    self = [super init];
    if (self)
    {
        Login = login;
        Password = password;
        Uuid = uuid;
        Name = name;
        StringFields = stringFields;
    }
    return self;
}
@end
