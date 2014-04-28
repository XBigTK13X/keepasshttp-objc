//
//  KPHGetLoginsCountHandler.m
//  keepasshttp-objc
//
//  Created by Tim Kretschmer on 4/5/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHGetLoginsCountHandler.h"

@implementation KPHGetLoginsCountHandler
- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes
{
    response.Success = true;
    response.Id = request.Id;
    
    NSString* url = [KPHCore CryptoTransform:request.Url base64in:true base64out:false aes:aes encrypt:false];
    NSString* submitHost = [KPHCore CryptoTransform:request.SubmitUrl base64in:true base64out:false aes:aes encrypt:false];
    NSString* realm = [KPHCore CryptoTransform:request.Realm base64in:true base64out:false aes:aes encrypt:false];
    
    response.Count = [[KPHUtil client] countMatchingEntries:url submitHost:submitHost realm:realm];
}
@end
