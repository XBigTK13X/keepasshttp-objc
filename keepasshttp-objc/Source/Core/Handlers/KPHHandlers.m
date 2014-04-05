//
//  KPHHandlers.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHHandlers.h"

@implementation KPHHandlers
- (id)init
{
    self = [super init];
    if(self){
        handlers = [NSMutableDictionary new];
        [handlers setObject:[KPHAssociationHandler new] forKey:[Request ASSOCIATE]];
    }
    return self;
}

- (NSObject<KPHRequestHandler>*) forRequest:(NSString*) requestType
{
    return [handlers objectForKey:requestType];
}
@end
