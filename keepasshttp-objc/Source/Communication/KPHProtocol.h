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
#import "KPHAes.h"
#import "KPHSystemConvert.h"
#import "KPHUtil.h"
#import "KPHCore.h"

@interface KPHProtocol : NSObject
+ (BOOL) verifyRequestt:(KPHRequest *) request aes:(KPHAes*)aes;
+ (BOOL) testRequestVerifier: (KPHRequest *) request aes:(KPHAes*)aes key:(NSString *) key;
+ (void) setResponseVerifier: (KPHResponse *) response aes:(KPHAes*) aes;
+ (void) encryptResponse:(KPHResponse*)response aes:(KPHAes*)aes;
@end
