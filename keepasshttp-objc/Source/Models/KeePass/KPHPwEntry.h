//
//  PwEntry.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KPHPwEntry : NSObject

@property (nonatomic) NSUUID* Uuid;
@property (nonatomic) NSMutableDictionary* Strings;
@property (nonatomic) NSUInteger UsageCount;
@property (nonatomic) NSDate* m_tCreation;
@property (nonatomic) NSDate* m_tLastMod;
@property (nonatomic) NSDate* m_tLastAccess;
@property (nonatomic) NSDate* m_tParentGroupLastMod;

- (id) initWithUuid:(NSUUID*)uuid;
- (id) init:(BOOL) createNewUuid setTimes:(BOOL) setTimes;
@end
