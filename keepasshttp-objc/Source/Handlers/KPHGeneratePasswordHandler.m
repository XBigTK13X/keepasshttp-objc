//
//  KPHGeneratePasswordHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGeneratePasswordHandler.h"

@implementation KPHGeneratePasswordHandler
- (void) handle: (KPHRequest*)request response:(KPHResponse*)response aes:(Aes*)aes
{
    KPHGeneratedPassword* generated = [[KPHUtil client] generatePassword];
    if (generated != nil)
    {
        //-(id) init:(NSString *) name login:(NSString *) login password:(NSString *) password uuid:(NSString *) uuid stringFields:(NSArray *) stringFields
        NSString* bitLength = [[NSString alloc] initWithFormat:@"%lu",(unsigned long)generated.BitLength];
        NSString* pass = [[NSString alloc] initWithFormat:@"%@",generated.Password];
        KPHResponseEntry* item = [[KPHResponseEntry alloc] init:[KPHUtil globalVars].RequestIds.GENERATE_PASSWORD login:bitLength password:pass uuid:[KPHUtil globalVars].RequestIds.GENERATE_PASSWORD stringFields:nil];
        [response.Entries addObject:item];
        response.Success = true;
        response.Count = 1;
    }
    
    response.Id = request.Id;
    [KPHProtocol SetResponseVerifier:response aes:aes];
    [KPHProtocol encryptResponse:response aes:aes];
}
@end
