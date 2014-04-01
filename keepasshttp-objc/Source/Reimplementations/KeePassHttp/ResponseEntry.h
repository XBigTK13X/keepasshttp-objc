//
//  ResponseEntry.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseStringField.h"

@interface ResponseEntry : NSObject
{
    NSString* Login;
    NSString* Password;
    NSString* Uuid;
    NSString* Name;
    NSArray* StringFields;
}

@end
