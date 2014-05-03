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

NSString* associateRequest = @"{\"RequestType\":\"associate\",\"Key\":\"3JMvMQtLw+9cbKKEt2bc/lijFZNsWV8P0BCQWVel+kU=\",\"Nonce\":\"OBvRHwUURbSMhVKUHqb1Tg==\",\"Verifier\":\"a1zLpr9GRXWMmj0THOPs01wFi3KOKc9oG/1JWiI1Gds=\"}";

NSString* testAssociateRequest = @"{\"RequestType\":\"test-associate\",\"TriggerUnlock\":false}";

NSString* getLoginsRequest = @"{\"RequestType\":\"get-logins\",\"SortSelection\":\"true\",\"TriggerUnlock\":\"false\",\"Id\":\"keepasshttp-objc mock\",\"Nonce\":\"2+6bul01/8X4pXswHNAo5g==\",\"Verifier\":\"9V+HAzkCAwWvlGTHtpbh5dtv9UlP4+RieKbMHUhijZE=\",\"Url\":\"DouPmLBouARHNluTg1/pKWempj2Iu7bH9/Jtr7D2c24=\",\"SubmitUrl\":\"DouPmLBouARHNluTg1/pKZjSrvloA9UfA21s9M9XgRSZNbE9WV7SGZzzVRZk4Vpq\"}";


@interface keepasshttp_objcTests : XCTestCase

@property (nonatomic) KPHDialogueEngine* engine;

@end

@implementation keepasshttp_objcTests
NSString* h = @"";

- (void)setUp
{
    [super setUp];
    [KPHUtil setClient:[KPHKeePassClientMock new]];
    self.engine = [KPHDialogueEngine new];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testTestAssociateHandlerWithoutAnyAssociation
{
    Response* response = [self.engine respond:testAssociateRequest];
    XCTAssertEqual(response.Success,NO, @"Should have failed.");
    
}

- (void)testAssociateHandler
{
    Response* response = [self.engine respond:associateRequest];
    XCTAssertEqual(response.Success,YES,@"Should have decrypted and stored key");
}

@end
