//
//  KPHGetLoginsUserResponse.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/16/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGetLoginsUserResponse.h"

@implementation KPHGetLoginsUserResponse
-(id) init
{
    self = [super init];
    if(self)
    {
        self.Accept = false;
        self.Remember = false;
    }
    return self;
}
@end
