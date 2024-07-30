//
//  EmployeeTableViewCell.m
//  iOS Assignment
//
//  Created by Hira Saleem on 28/07/2024.
//

#import "EmployeeTableViewCell.h"

@interface EmployeeTableViewCell ()

@property (nonatomic, strong) UIImageView *employeeImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *biographyLabel;

@end

@implementation EmployeeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.employeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    self.employeeImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.employeeImageView.clipsToBounds = YES;
    self.employeeImageView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.employeeImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, self.contentView.frame.size.width - 90, 20)];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, self.contentView.frame.size.width - 90, 20)];
    self.phoneNumberLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.phoneNumberLabel];
    
    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, self.contentView.frame.size.width - 90, 20)];
    self.emailLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.emailLabel];
    
    self.biographyLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 70, self.contentView.frame.size.width - 90, 40)];
    self.biographyLabel.font = [UIFont systemFontOfSize:12];
    self.biographyLabel.numberOfLines = 2;
    [self.contentView addSubview:self.biographyLabel];
}

- (void)configureWithEmployee:(Employee *)employee {
    self.nameLabel.text = employee.name;
    self.phoneNumberLabel.text = employee.phoneNumber;
    self.emailLabel.text = employee.email;
    self.biographyLabel.text = employee.biography;
    
    // Load image asynchronously
    NSURL *url = [NSURL URLWithString:employee.photoURL];
    if (url) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.employeeImageView.image = image;
                    [self setNeedsLayout];
                });
            }
        });
    }
}

@end
