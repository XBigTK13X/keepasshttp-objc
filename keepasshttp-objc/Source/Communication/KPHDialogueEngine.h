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

#import "KPHHandlers.h"
#import "SystemConvert.h"

//#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface KPHDialogueEngine : NSObject

@property (nonatomic) KPHHandlers* handlers;

- (Response*) respond:(NSString*)requestJSON;
- (NSString*) respondAsJSON:(NSString*)requestJSON;
@end
