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
+ (NSString*) getHost:(NSString *)uri
{
    NSString* host = uri;
    NSURL *url = [[NSURL alloc] initWithString:host];
    if(url != nil){
        host = url.host;
        if (url.port != nil)
        {
            host = [NSString stringWithFormat:@"%@:%@",host,url.port];
        }
    }
    return host;
}
+ (NSString*) trim:(NSString *)string
{
    NSString* trimmed = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([trimmed length] == 0)
    {
        return nil;
    }
    return trimmed;
}
+(BOOL)stringIsNilOrEmpty:(NSString*)value {
    return !(value && value.length);
}
@end
