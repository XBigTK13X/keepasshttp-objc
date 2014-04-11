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
    NSString* keyId = [[KPHUtil client] promptUserForKeyName];
    if(keyId != nil)
    {
        NSString* keyConfigId = [KPHUtil associateKeyId:keyId];
        PwEntry* entry = [KPHCore GetConfigEntry:true];
        BOOL keyNameExists = true;
        while(keyNameExists){
            BOOL overwriteConfirmed = true;
            for(id existingKey in entry.Strings){
                if([existingKey isEqual:keyConfigId]){
                    overwriteConfirmed = [[KPHUtil client] promptUserForOverwrite];
                }
            }
            if(overwriteConfirmed){
                keyNameExists = false;
            }
            else{
                //TODO Might need to call something like [client tryAgain]
            }
        }
        entry.Strings[keyConfigId] = request.Key;
        [entry Touch:true];
        response.Id = keyId;
        response.Success = true;
        [KPHProtocol SetResponseVerifier:response aes:aes];
        [[KPHUtil client] updateUI];
    }
}

@end
