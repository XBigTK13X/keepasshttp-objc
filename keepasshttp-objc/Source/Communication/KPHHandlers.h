//
//  KPHHandlers.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KPHRequestHandler.h"
#import "KPHAssociateHandler.h"
#import "KPHTestAssociateHandler.h"
#import "KPHGetLoginsCountHandler.h"
#import "KPHGetLoginsHandler.h"
#import "KPHGetAllLoginsHandler.h"
#import "KPHSetLoginHandler.h"
#import "KPHGeneratePasswordHandler.h"

@interface KPHHandlers : NSObject

@property (nonatomic) NSDictionary* handlers;

- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType;
@end
