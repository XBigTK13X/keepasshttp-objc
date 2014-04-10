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

@property (nonatomic) PwUuid* Uuid;
@property (nonatomic) NSMutableDictionary* Strings;
@property (nonatomic) NSDate* m_tCreation;
@property (nonatomic) NSDate* m_tLastMod;
@property (nonatomic) NSDate* m_tLastAccess;
@property (nonatomic) NSDate* m_tParentGroupLastMod;

- (id) init:(BOOL) createNewUuid setTimes:(BOOL) setTimes;
- (NSString* ) getString: (NSString * )lookup;
@end
