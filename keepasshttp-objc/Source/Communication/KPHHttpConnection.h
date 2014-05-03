//
//  SPSHttpConnection.h
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "HTTPConnection.h"
#import "HTTPDataResponse.h"
#import "KPHDialogueEngine.h"

#import "Logging.h"

@interface KPHHttpConnection : HTTPConnection

@property (nonatomic) KPHDialogueEngine* engine;

+ (int) defaultPort;
@end
