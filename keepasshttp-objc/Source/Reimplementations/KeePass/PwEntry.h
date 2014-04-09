//
//  PwEntry.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PwUuid.h"
@interface PwEntry : NSObject
{
    @public PwUuid* Uuid;
    @public NSMutableDictionary* Strings;
    
    NSDate* m_tCreation;
    NSDate* m_tLastMod;
    NSDate* m_tLastAccess;
    NSDate* m_tParentGroupLastMod;
}
- (id) init:(BOOL) createNewUuid setTimes:(BOOL) setTimes;
- (NSString* ) getString: (NSString * )lookup;
@end
