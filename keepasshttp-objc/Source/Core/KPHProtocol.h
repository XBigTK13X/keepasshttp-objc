//
//  SPSProtocol.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "Request.h"
#import "Aes.h"
#import "SystemConvert.h"
#import "KPHUtil.h"
#import "KPHCore.h"

@interface KPHProtocol : NSObject
+ (BOOL) VerifyRequest:(Request *) request aes:(Aes*)aes;
+ (BOOL) TestRequestVerifier: (Request *) request aes:(Aes*)aes key:(NSString *) key;
+ (void) SetResponseVerifier: (Response *) response aes:(Aes*) aes;
@end
