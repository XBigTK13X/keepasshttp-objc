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
    if(![KPHProtocol TestRequestVerifier:request aes:aes key:request.Key])
        return;
    NSString* keyMessage = [[NSString alloc] initWithFormat:@"You have received an association request for the key \"%@\". If you would like to allow it access to your KeePass database give it a unique name to identify and accept it.",request.Key];
    NSString* keyId = [[KPHUtil client] promptUserForKeyName: keyMessage];
    if(keyId != nil)
    {
        NSString* keyConfigId = [KPHUtil associateKeyId:keyId];
        PwEntry* entry = [KPHCore GetConfigEntry:true];
        BOOL keyNameExists = true;
        while(keyNameExists){
            BOOL overwriteConfirmed = true;
            for(id existingKey in entry.Strings){
                if([existingKey isEqual:keyConfigId]){
                    NSString* overwriteMessage = [[NSString alloc] initWithFormat: @"A shared encryption-key with the name \"%@\" already exists.\nDo you want to overwrite it?",keyId];
                    overwriteConfirmed = [[KPHUtil client] promptUserForOverwrite:overwriteMessage title:@"Overwrite existing key?"];
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
        [[KPHUtil client] updateUI];
    }
}

@end
