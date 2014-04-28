//
//  KPHGeneratePassword.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/27/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGeneratedPassword.h"

@implementation KPHGeneratedPassword
- (id) init:(NSString*)password bitLength:(NSUInteger)bitLength
{
    self = [super init];
    if(self)
    {
        self.Password = password;
        self.BitLength = bitLength;
    }
    return self;
}
@end
