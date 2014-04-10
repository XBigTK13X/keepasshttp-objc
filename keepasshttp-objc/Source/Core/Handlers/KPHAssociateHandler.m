//
//  SPSAssociationHandler.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHAssociateHandler.h"

@implementation KPHAssociateHandler

- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes;
{
    if (![KPHProtocol TestRequestVerifier:request aes:aes key:request.Key])
        return;
    
    NSString* keyId = [[KPHUtil client] promptUserForKeyName];
    if(keyId != nil)
    {
        NSString* keyConfigId = [NSString stringWithFormat:@"%@%@",[KPHUtil globalVars].ASSOCIATE_KEY_PREFIX,keyId];
        PwEntry* entry = [KPHCore GetConfigEntry:true];
        BOOL keyNameExists = true;
        while(keyNameExists){
            BOOL overwriteConfirmed = true;
            for(id key in entry.Strings){
                if([key isEqual:keyConfigId]){
                    overwriteConfirmed = [[KPHUtil client] promptUserForOverwrite];
                }
            }
            if(overwriteConfirmed){
                keyNameExists = false;
            }
            else{
                //TODO Might need to call something like [client closeNotification]
            }
        }
        entry.Strings[keyConfigId] = request.Key;
        response.Id = keyId;
        response.Success = true;
        [KPHProtocol SetResponseVerifier:response aes:aes];
        [[KPHUtil client] updateUI];
    }
}

@end
