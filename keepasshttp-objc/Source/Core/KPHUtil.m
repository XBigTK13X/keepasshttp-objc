//
//  SPSKeePassUtil.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHUtil.h"

@implementation KPHUtil

static NSObject<KPHKeePassClient> *clientSingleton;
static KPHGlobalVars *globalVarsSingleton;
+ (KPHGlobalVars*) globalVars
{
    @synchronized(self)
    {
        if(globalVarsSingleton == nil){
            globalVarsSingleton = [KPHGlobalVars new];
        }
        return globalVarsSingleton;
    }
}
+ (NSObject<KPHKeePassClient>*) client
{
    @synchronized(self)
    {
        return clientSingleton;
    }
}
+ (void) setClient: (NSObject<KPHKeePassClient>*)client
{
    @synchronized(self)
    {
        clientSingleton = client;
    }
}
+ (NSString*) associateKeyId:(NSString*)key
{
    return [NSString stringWithFormat:@"%@%@",[KPHUtil globalVars].ASSOCIATE_KEY_PREFIX,key];
}
@end
