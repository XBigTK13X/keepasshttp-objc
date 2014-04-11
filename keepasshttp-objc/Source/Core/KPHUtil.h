//
//  SPSKeePassUtil.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHKeePassClient.h"
#import "KPHGlobalVars.h"

@interface KPHUtil : NSObject
+ (KPHGlobalVars*) globalVars;
+ (NSObject<KPHKeePassClient>*) client;
+ (void) setClient: (NSObject<KPHKeePassClient>*)client;
+ (NSString*) associateKeyId:(NSString*)key;
@end
