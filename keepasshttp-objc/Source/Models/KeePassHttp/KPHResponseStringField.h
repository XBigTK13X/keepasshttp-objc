//
//  ResponseStringField.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPHResponseStringField : NSObject

@property (nonatomic) NSString* Key;
@property (nonatomic) NSString* Value;

-(id) init: (NSString*) key value:(NSString*) value;

@end
