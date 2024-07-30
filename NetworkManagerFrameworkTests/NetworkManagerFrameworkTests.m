//
//  NetworkManagerFrameworkTests.m
//  NetworkManagerFrameworkTests
//
//  Created by Hira Saleem on 28/07/2024.
//

#import <XCTest/XCTest.h>
#import "NetworkManager.h"

@interface NetworkManagerFrameworkTests : XCTestCase

@end

@implementation NetworkManagerFrameworkTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testSuccessfulNetworkCall {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Network Request"];
    
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/sq-mobile-interview/employees.json"];
    [[NetworkManager sharedManager] getDataFromURL:url success:^(NSData *data) {
        XCTAssertNotNil(data, "Data should not be nil");
        NSError *jsonError;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        XCTAssertNil(jsonError, "JSON Parsing error should be nil");
        XCTAssertNotNil(jsonDict[@"employees"], "Employees data should not be nil");
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTFail("Request failed with error: %@", error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testFailedNetworkCall {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Network Request"];
    
    NSURL *url = [NSURL URLWithString:@"https://invalid-url.com"];
    [[NetworkManager sharedManager] getDataFromURL:url success:^(NSData *data) {
        XCTFail("Request should not succeed");
        [expectation fulfill];
    } failure:^(NSError *error) {
        XCTAssertNotNil(error, "Error should not be nil");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}


@end
