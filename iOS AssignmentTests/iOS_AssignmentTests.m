//
//  iOS_AssignmentTests.m
//  iOS AssignmentTests
//
//  Created by Hira Saleem on 28/07/2024.
//

#import <XCTest/XCTest.h>
#import "EmployeeListViewController.h"
#import "Employee.h"
#import "Constants.h"
#import <NetworkManagerFramework/NetworkManager.h>

@interface EmployeeListViewControllerTests : XCTestCase

@property (nonatomic, strong) EmployeeListViewController *viewController;

@end

@implementation EmployeeListViewControllerTests

- (void)setUp {
    [super setUp];
    self.viewController = [[EmployeeListViewController alloc] init];
    [self.viewController loadViewIfNeeded];
}

- (void)tearDown {
    self.viewController = nil;
    [super tearDown];
}

- (void)testViewControllerTitle {
    XCTAssertEqualObjects(self.viewController.title, NSLocalizedString(@"employee_directory", @"Employee Directory"));
}

- (void)testTableViewNotNil {
    XCTAssertNotNil(self.viewController.tableView, "TableView should not be nil");
}

- (void)testPlaceholderLabel {
    XCTAssertNotNil(self.viewController.placeholderLabel, "PlaceholderLabel should not be nil");
    XCTAssertEqualObjects(self.viewController.placeholderLabel.text, NSLocalizedString(@"no_employees_found", @"No employees found."));
}

- (void)testFetchEmployees {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch Employees"];
    
    NSURL *url = [NSURL URLWithString:kEmployeesURL];
    [[NetworkManager sharedManager] getDataFromURL:url success:^(NSData *data) {
        NSError *jsonError;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        XCTAssertNil(jsonError, "JSON Parsing error should be nil");
        
        NSArray *employeeArray = jsonDict[@"employees"];
        if ([employeeArray isKindOfClass:[NSArray class]] && employeeArray.count > 0) {
            NSMutableArray<Employee *> *employees = [NSMutableArray array];
            for (NSDictionary *employeeDict in employeeArray) {
                if ([employeeDict isKindOfClass:[NSDictionary class]]) {
                    Employee *employee = [[Employee alloc] initWithDictionary:employeeDict];
                    [employees addObject:employee];
                }
            }
            self.viewController.employees = employees;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.viewController.tableView reloadData];
                XCTAssertEqual([self.viewController.tableView numberOfRowsInSection:0], employees.count);
                [expectation fulfill];
            });
        } else {
            XCTFail("Employees data should not be nil or empty");
            [expectation fulfill];
        }
    } failure:^(NSError *error) {
        XCTFail("Request failed with error: %@", error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
