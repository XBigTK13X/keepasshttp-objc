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

NSString* aesKey = @"uckPcTCgNrYVEXON6KWuC+ds3fnOx+tOTwlHCUe/RQU=";

NSString* associateRequest = @"{\"RequestType\":\"associate\",\"Key\":\"uckPcTCgNrYVEXON6KWuC+ds3fnOx+tOTwlHCUe/RQU=\",\"Nonce\":\"ZOQRnNQfIHUUm3D3twbrUw==\",\"Verifier\":\"QWLnuNpqNhXjCXYvO4FcruA03MIAQa2OtfVcRsHjJ+s=\"}";

NSString* getLoginsCountRequest = @"{\"RequestType\":\"get-logins-count\",\"Id\":\"keepasshttp-objc mock\",\"Nonce\":\"Blm0rb0QBws/Q7HJQwiD/Q==\",\"Verifier\":\"DUnEkDuYHkNIYZ16epg0kzkS0x+oZWtNGBXAQmrBOuA=\",\"Url\":\"invbCCMnvJya75JiHMxdWAz4OiD8ouObiqX4rFWQt3s=\"}";

NSString* getLoginsRequest = @"{\"RequestType\":\"get-logins\",\"Id\":\"keepasshttp-objc mock\",\"Nonce\":\"p9yMTiHVFfBgarzEpsotLQ==\",\"Verifier\":\"HsI679V9ptkrB+639sH2TURclBh+S1ozo6PhjbLd/jE=\",\"Url\":\"RuSDKnyfpptowR0gyWS8Qle10CxVsCp3xOs3uSa57aw=\",\"SubmitUrl\":\"oUv073LqpcbGfFxxI9m/cMA2fdQhXuchNrhDjzRUyl4=\"}";

NSString* getAllLoginsRequest = @"{\"RequestType\":\"get-all-logins\",\"Id\":\"keepasshttp-objc mock\",\"Nonce\":\"paU6m4WXyjUH5t0AMvssLA==\",\"Verifier\":\"Mq51zZZPsmBq5WEwMY60ET786YmlmusTl+ofaEA1vzM=\"}";

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

@interface FirefoxTests : XCTestCase

@end

@implementation FirefoxTests

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

- (void)test001AssociateHandler
{
    KPHResponse* response = [[singletons engine] respond:associateRequest];
    XCTAssertEqual(response.Success,YES,@"Should have decrypted and stored key");
}

- (void)test002GetLoginsCountHandler
{
    KPHResponse* response = [[singletons engine] respond:getLoginsCountRequest];
    XCTAssertEqual(response.Count,1,@"Should have found 1 entry");
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

- (void)test003GetAllLoginsHandler
{
    KPHResponse* response = [[singletons engine] respond:getAllLoginsRequest];
    XCTAssertEqual(response.Entries.count, 1,@"Should have returned 1 entry");
}

@end
