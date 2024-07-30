//
//  EmployeeListViewController.h
//  iOS Assignment
//
//  Created by Hira Saleem on 28/07/2024.
//


#import <UIKit/UIKit.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeListViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Employee *> *employees;
@property (nonatomic, strong) UILabel *placeholderLabel;
@end

NS_ASSUME_NONNULL_END
