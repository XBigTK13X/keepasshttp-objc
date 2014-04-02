//
//  KeyPassHttpEntryConfig.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeePassHttpEntryConfig : NSObject
{
    //Set of strings
    NSSet* Allow;
    //Set of string
    NSSet* Deny;
    NSString* Realm;
}
@end
