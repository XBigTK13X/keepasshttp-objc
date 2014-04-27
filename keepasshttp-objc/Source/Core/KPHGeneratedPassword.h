//
//  KPHGeneratePassword.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/27/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPHGeneratedPassword : NSObject

@property (nonatomic) NSString* Password;
@property (nonatomic) NSUInteger BitLength;

- (id) init:(NSString*)password bitLength:(NSUInteger)bitLength;
@end
