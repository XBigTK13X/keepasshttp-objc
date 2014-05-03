//
//  KPHDialogueEngine.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJSONDeserializer.h"
#import "NSDictionary_JSONExtensions.h"
#import "NSString+Hashes.h"

#import "KPHLogging.h"
#import "KPHHandlers.h"
#import "SystemConvert.h"


@interface KPHDialogueEngine : NSObject

@property (nonatomic) KPHHandlers* handlers;

- (KPHResponse*) respond:(NSString*)requestJSON;
- (NSString*) respondAsJSON:(NSString*)requestJSON;
@end
