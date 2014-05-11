//
//  KPHTestAssociateHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHTestAssociateHandler.h"

@implementation KPHTestAssociateHandler
- (void) handle: (KPHRequest*)request response:(KPHResponse*)response aes:(KPHAes*)aes;
{
    response.Success = true;
    response.Id = request.Id;
}
@end
