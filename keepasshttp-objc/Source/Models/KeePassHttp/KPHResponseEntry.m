//
//  ResponseEntry.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHResponseEntry.h"

@implementation KPHResponseEntry
-(id) init:(NSString *) name login:(NSString *) login password:(NSString *) password uuid:(NSString *) uuid stringFields:(NSArray *) stringFields
{
    self = [super init];
    if (self)
    {
        self.Login = login;
        self.Password = password;
        self.Uuid = uuid;
        self.Name = name;
        self.StringFields = stringFields;
    }
    return self;
}
@end
