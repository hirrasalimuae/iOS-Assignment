//
//  EmployeeTableViewCell.h
//  iOS Assignment
//
//  Created by Hira Saleem on 28/07/2024.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeTableViewCell : UITableViewCell

- (void)configureWithEmployee:(Employee *)employee;

@end

NS_ASSUME_NONNULL_END
