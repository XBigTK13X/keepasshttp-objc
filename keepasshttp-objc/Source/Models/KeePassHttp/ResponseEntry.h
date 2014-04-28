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

@property (nonatomic) NSString* Login;
@property (nonatomic) NSString* Password;
@property (nonatomic) NSString* Uuid;
@property (nonatomic) NSString* Name;
//Array of ResponseStringField
@property (nonatomic) NSArray* StringFields;

-(id) init:(NSString *) name login:(NSString *) login password:(NSString *) password uuid:(NSString *) uuid stringFields:(NSArray *) stringFields;

@end
