//
//  SearchParameters.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/18/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "SearchParameters.h"

@implementation SearchParameters
- (id) init
{
    self = [super init];
    if(self){
        self.SearchInTitles = true;
        self.RegularExpression = true;
        self.SearchInGroupNames = false;
        self.SearchInNotes = false;
        self.SearchInOther = false;
        self.SearchInPasswords = false;
        self.SearchInTags = false;
        self.SearchInUrls = true;
        self.SearchInUserNames = false;
        self.SearchInUuids = false;
    }
    return self;
}
@end
