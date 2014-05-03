//
//  KPHKeePassMockClient.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/10/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPHKeePassClient.h"

@interface KPHKeePassClientMock : NSObject<KPHKeePassClient>

@property (nonatomic) KPHPwGroup* root;
@property (nonatomic) KPHPwGroup* recycle;
@property (nonatomic) KPHPwEntry* validEntry;
@property (nonatomic) NSString* knownHost;

@end
