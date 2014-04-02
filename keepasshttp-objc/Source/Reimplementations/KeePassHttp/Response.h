//
//  Response.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "AssemblyInfo.h"

@interface Response : NSObject<NSObject>{
    @public NSString* RequestType;
    @public NSString* Error;
    @public BOOL Success;
    @public NSString* Id;
    @public int Count;
    @public NSString* Version;
    @public NSString* Hash;
    @public NSArray* Entries;
    @public NSString* Nonce;
    @public NSString* Verifier;
}

@end
