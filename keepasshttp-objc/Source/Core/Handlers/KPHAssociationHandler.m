//
//  SPSAssociationHandler.m
//  keypasshttp
//
//  Created by Tim Kretschmer on 3/28/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import "KPHAssociationHandler.h"

@implementation KPHAssociationHandler

- (void) handle: (Request*)request response:(Response*)response aes:(Aes*)aes;
{
    NSLog(@"Handling request - associate");
    if (![KPHProtocol TestRequestVerifier:request aes:aes  key:request->Key])
        return;
    
    // key is good, prompt user to save
    /*
    using (var f = new ConfirmAssociationForm())
    {
        var win = host.MainWindow;
        win.Invoke((MethodInvoker)delegate
                   {
                       f.Activate();
                       f.Icon = win.Icon;
                       f.Key = r.Key;
                       f.Load += delegate { f.Activate(); };
                       f.ShowDialog(win);
                       
                       if (f.KeyId != null)
                       {
                           var entry = GetConfigEntry(true);
                           
                           bool keyNameExists = true;
                           while (keyNameExists)
                           {
                               DialogResult keyExistsResult = DialogResult.Yes;
                               foreach (var s in entry.Strings)
                               {
                                   if (s.Key == ASSOCIATE_KEY_PREFIX + f.KeyId)
                                   {
                                       keyExistsResult = MessageBox.Show(
                                                                         win,
                                                                         "A shared encryption-key with the name \"" + f.KeyId + "\" already exists.\nDo you want to overwrite it?",
                                                                         "Overwrite existing key?",
                                                                         MessageBoxButtons.YesNo,
                                                                         MessageBoxIcon.Warning,
                                                                         MessageBoxDefaultButton.Button1
                                                                         );
                                       break;
                                   }
                               }
                               
                               if (keyExistsResult == DialogResult.No)
                               {
                                   f.ShowDialog(win);
                               }
                               else
                               {
                                   keyNameExists = false;
                               }
                           }
                           
                           if (f.KeyId != null)
                           {
                               entry.Strings.Set(ASSOCIATE_KEY_PREFIX + f.KeyId, new ProtectedString(true, r.Key));
                               entry.Touch(true);
                               resp.Id = f.KeyId;
                               resp.Success = true;
                               SetResponseVerifier(resp, aes);
                               UpdateUI(null);
                           }
                       }
                   });
     
    }
     */
}

- (void) TestAssociateHandler: (Request*) r resp:(Response*) resp aes:(Aes*) aes
{
    if (![KPHProtocol VerifyRequest:r aes:aes])
        return;
    
    resp->Success = true;
    resp->Id = r->Id;
    [KPHProtocol SetResponseVerifier:resp aes:aes];
}

@end
