//
//  EmployeeListViewController.m
//  iOS Assignment
//
//  Created by Hira Saleem on 28/07/2024.
//

#import "EmployeeListViewController.h"
#import <NetworkManagerFramework/NetworkManager.h>

#import "EmployeeTableViewCell.h"
#import "Constants.h"

@interface EmployeeListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"employee_directory", @"Employee Directory");
    
    [self setupTableView];
    [self setupPlaceholderLabel];
    
    [self fetchEmployees];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[EmployeeTableViewCell class] forCellReuseIdentifier:@"EmployeeCell"];
    [self.view addSubview:self.tableView];
}

- (void)setupPlaceholderLabel {
    self.placeholderLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.placeholderLabel.text = NSLocalizedString(@"no_employees_found", @"No employees found.");
    self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
    self.placeholderLabel.textColor = [UIColor grayColor];
    self.placeholderLabel.hidden = YES;
    [self.view addSubview:self.placeholderLabel];
}

- (void)fetchEmployees {
    NSURL *url = [NSURL URLWithString:kEmployeesURL];
    [[NetworkManager sharedManager] getDataFromURL:url success:^(NSData *data) {
        NSError *jsonError;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (!jsonError) {
            NSArray *employeeArray = jsonDict[@"employees"];
            if ([employeeArray isKindOfClass:[NSArray class]] && employeeArray.count > 0) {
                NSMutableArray<Employee *> *employees = [NSMutableArray array];
                for (NSDictionary *employeeDict in employeeArray) {
                    if ([employeeDict isKindOfClass:[NSDictionary class]]) {
                        Employee *employee = [[Employee alloc] initWithDictionary:employeeDict];
                        [employees addObject:employee];
                    }
                }
                self.employees = employees;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.placeholderLabel.hidden = YES;
                    [self.tableView reloadData];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.placeholderLabel.text = NSLocalizedString(@"no_employees_found", @"No employees found.");
                    self.placeholderLabel.hidden = NO;
                    [self.tableView reloadData];
                });
            }
        } else {
            [self showErrorAlert];
        }
    } failure:^(NSError *error) {
        [self showErrorAlert];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.employees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmployeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell" forIndexPath:indexPath];
    [cell configureWithEmployee:self.employees[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)showErrorAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.placeholderLabel.text = NSLocalizedString(@"failed_to_load_employees", @"Failed to load employees.");
        self.placeholderLabel.hidden = NO;
    });

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"error", @"Error") message:NSLocalizedString(@"failed_to_load_employees", @"Failed to load employees.") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"retry", @"Retry") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fetchEmployees];
    }];
    [alertController addAction:retryAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
