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
    
    NSString* keyId = [NSString stringWithFormat:@"%@%@",[KPHUtil globalVars].ASSOCIATE_KEY_PREFIX,response.Hash];
    
    if([[KPHUtil client] showAssociationConfirmation])
    {
        PwEntry* entry = [KPHCore GetConfigEntry:true];
        BOOL keyNameExists = true;
        while(keyNameExists){
            BOOL overwriteConfirmed = true;
            for(id key in entry.Strings){
                if([key isEqual:keyId]){
                    overwriteConfirmed = [[KPHUtil client] showOverwriteKeyConfirmation];
                }
            }
            if(!overwriteConfirmed){
                //Try again? Need to look more into what actually generates f.KeyId
            }
            else{
                keyNameExists = false;
            }
        }
        entry.Strings[keyId] = request.Key;
        response.Id = request.Key;
        response.Success = true;
        [KPHProtocol SetResponseVerifier:response aes:aes];
        [[KPHUtil client] updateUI];
    }
}

@end
