//
//  SearchParameters.h
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/18/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchParameters : NSObject
@property (nonatomic) BOOL SearchInTitles;
@property (nonatomic) BOOL RegularExpression;
@property (nonatomic) BOOL SearchInGroupNames;
@property (nonatomic) BOOL SearchInNotes;
@property (nonatomic) BOOL SearchInOther;
@property (nonatomic) BOOL SearchInPasswords;
@property (nonatomic) BOOL SearchInTags;
@property (nonatomic) BOOL SearchInUrls;
@property (nonatomic) BOOL SearchInUserNames;
@property (nonatomic) BOOL SearchInUuids;
@property (nonatomic) NSString* SearchString;
@end
