//
//  PwDefs.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "PwDefs.h"

@implementation PwDefs
- (id)init
{
    self = [super init];
    if(self){
        self.TitleField = @"Title";
        self.UrlField = @"URL";
        self.PasswordField = @"Password";
        self.UserNameField = @"UserName";
    }
    return self;
}
@end
