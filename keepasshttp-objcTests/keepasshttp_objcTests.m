//
//  keepasshttp_objcTests.m
//  keepasshttp-objcTests
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPHDialogueEngine.h"
#import "KPHKeePassClientMock.h"
#import "KPHLogging.h"
#import "SystemConvert.h"

NSString* aesKey = @"hMGok15pLI1l68ZmqK0T7l9Kmj3EM3I6GfkD2wycy9o=";

NSString* associateRequest = @"{\"RequestType\":\"associate\",\"Key\":\"hMGok15pLI1l68ZmqK0T7l9Kmj3EM3I6GfkD2wycy9o=\",\"Nonce\":\"5ltuteOjkftYlRttagwpkA==\",\"Verifier\":\"7urIefzx5l/dBiOnqE84Zp7J/GJyNbgfzs/e921IKQo=\"}";

NSString* testAssociateRequest = @"{\"RequestType\":\"test-associate\",\"TriggerUnlock\":false}";

NSString* getLoginsRequest = @"{\"RequestType\":\"get-logins\",\"SortSelection\":\"true\",\"TriggerUnlock\":\"false\",\"Id\":\"keepasshttp-objc mock\",\"Nonce\":\"07Wlik0Sf+HJWjNTdWylCA==\",\"Verifier\":\"ajf0Z389PUNdeNKS3sfMCH5DDstbZ1DZ2h43VR8B6GY=\",\"Url\":\"SfxuZYEFqiwW8xvGKusTGpN0DRoJdevLIMMQ3BX0kdM=\",\"SubmitUrl\":\"VGE19VGQNVNCb30mCSCfrlA+6snzEanexDGjdzgc9FbQDpcz0/pw2c1kTs0zt2Lv\"}";

@interface singletons: NSObject
+ (KPHDialogueEngine*) engine;
@end
@implementation singletons
static KPHDialogueEngine *engineSingleton;

+ (KPHDialogueEngine*) engine
{
    @synchronized(self)
    {
        if(engineSingleton == nil){
            engineSingleton = [KPHDialogueEngine new];
            [KPHUtil setClient:[KPHKeePassClientMock new]];
        }
        return engineSingleton;
    }
}
@end

@interface keepasshttp_objcTests : XCTestCase

@end

@implementation keepasshttp_objcTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}


//Associate handler always fails for chromeipass
//Even after association
- (void)test000TestAssociateHandlerW
{
    KPHResponse* response = [[singletons engine] respond:testAssociateRequest];
    XCTAssertEqual(response.Success,NO, @"Should have failed.");
}

- (void)test001AssociateHandler
{
    KPHResponse* response = [[singletons engine] respond:associateRequest];
    XCTAssertEqual(response.Success,YES,@"Should have decrypted and stored key");
}


- (void)test002GetLoginsHandler
{
    KPHResponse* response = [[singletons engine] respond:getLoginsRequest];
    NSString* encryptedPassword = ((KPHResponseEntry*)[response.Entries objectAtIndex:0]).Password;
    Aes* aes = [Aes new];
    aes.Key = [SystemConvert FromBase64String:aesKey];
    aes.IV = [SystemConvert FromBase64String:response.Nonce];
    NSString* decryptedPassword = [KPHCore CryptoTransform:encryptedPassword base64in:true base64out:false aes:aes encrypt:false];
    XCTAssertEqualObjects(decryptedPassword, @"KeePass1",@"Decrypted password should match");
}

@end
