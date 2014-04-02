//
//  Response.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "ResponseEntry.h"

@interface Response : NSObject<NSObject>{
    NSString* RequestType;
    NSString* Error;
    BOOL Success;
    NSString* Id;
    int Count;
    NSString* Version;
    NSString* Hash;
    NSArray* Entries;
    NSString* Nonce;
    NSString* Verifier;
}

@end
