//
//  keepasshttp_objcTests.m
//  keepasshttp-objcTests
//
//  Created by Tim Kretschmer on 4/1/14.
//  Copyright (c) 2014 xbigtk13x. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPHDialogueEngine.h"
@interface keepasshttp_objcTests : XCTestCase

@property (nonatomic) KPHDialogueEngine* engine;

@end

@implementation keepasshttp_objcTests

- (void)setUp
{
    [super setUp];
    self.engine = [KPHDialogueEngine new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1TestAssociateHandlerWithoutAnyAssociation
{
    NSString* request = @"{\"RequestType\":\"test-associate\",\"TriggerUnlock\":false}";
    Response* response = [self.engine respond:request];
    XCTAssertEqual(response.Success,NO, @"Should have failed.");
    
}

- (void)test2AssociateHandler
{
    NSString* request = @"{\"RequestType\":\"associate\",\"Key\":\"ru3VlJvLRrE088Fk1u84F+PI4UGQX/WB1Qfpoi1CL3g=\",\"Nonce\":\"JJQlLpByiAf22te96V3Fbw==\",\"Verifier\":\"3etH4Bg489wGZjCCBFA6SOq7tQQfukcw1l9O7BMP6jQ=\"}";
    Response* response = [self.engine respond:request];
    XCTAssertEqual(response.Success,YES,@"Should have decrypted and stored key");
}

@end
