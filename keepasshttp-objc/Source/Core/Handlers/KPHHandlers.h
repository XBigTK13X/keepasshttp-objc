//
//  KPHHandlers.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KPHRequestHandler.h"
#import "KPHAssociationHandler.h"

@interface KPHHandlers : NSObject
{
    NSMutableDictionary* handlers;
}
- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType;
@end
