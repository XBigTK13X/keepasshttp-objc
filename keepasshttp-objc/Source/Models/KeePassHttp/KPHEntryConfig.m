//
//  KeyPassHttpEntryConfig.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHEntryConfig.h"
#import "KPHSystemConvert.h"
#import "NSDictionary_JSONExtensions.h"

@implementation KPHEntryConfig
- (id) initWithJson:(NSString*)json
{
    self = [super init];
    if(self)
    {
        NSError *error = NULL;
        NSDictionary *jsonDict = [NSDictionary dictionaryWithJSONString:json error:&error];
        if(jsonDict[@"Realm"] != nil){
            self.Realm = jsonDict[@"Realm"];
        }
        self.Allow = [NSMutableSet new];
        if(jsonDict[@"Allow"] != nil){
            for(NSString* allowed in jsonDict[@"Allow"]){
                [self.Allow addObject:allowed];
            }
        }
        self.Deny = [NSMutableSet new];
        if(jsonDict[@"Deny"] != nil){
            for(NSString* denied in jsonDict[@"Deny"]){
                [self.Deny addObject:denied];
            }
        }
    }
    return self;
}
- (NSString*) toJson
{
    NSMutableString* json = [NSMutableString new];
    [json appendString:@"{"];
    if(self.Realm != nil){
        [json appendString: [KPHSystemConvert toJSON:@"Realm" value:self.Realm]];
        [json appendString:@","];
    }
    if(self.Allow != nil){        
        [json appendString:@"\"Allow\":["];
        for(NSString* allowed in self.Allow){
            [json appendString:[NSString stringWithFormat:@"\"%@\",",allowed]];
        }
        [json deleteCharactersInRange:NSMakeRange([json length]-1, 1)];
        [json appendString:@"]"];
        [json appendString:@","];
    }
    if(self.Deny != nil){
        [json appendString:@"\"Deny\":["];
        for(NSString* denied in self.Deny){
            [json appendString:[NSString stringWithFormat:@"\"%@\",",denied]];
        }
        [json deleteCharactersInRange:NSMakeRange([json length]-1, 1)];
        [json appendString:@"]"];
        [json appendString:@","];
    }
    [json deleteCharactersInRange:NSMakeRange([json length]-1, 1)];
    [json appendString:@"}"];
    return json;
}
@end
