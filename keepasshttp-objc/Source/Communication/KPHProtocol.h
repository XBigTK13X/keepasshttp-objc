//
//  SPSProtocol.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHResponse.h"
#import "KPHRequest.h"
#import "Aes.h"
#import "SystemConvert.h"
#import "KPHUtil.h"
#import "KPHCore.h"

@interface KPHProtocol : NSObject
+ (BOOL) VerifyRequest:(KPHRequest *) request aes:(Aes*)aes;
+ (BOOL) TestRequestVerifier: (KPHRequest *) request aes:(Aes*)aes key:(NSString *) key;
+ (void) SetResponseVerifier: (KPHResponse *) response aes:(Aes*) aes;
+ (void) encryptResponse:(KPHResponse*)response aes:(Aes*)aes;
@end
