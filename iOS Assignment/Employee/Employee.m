//
//  Employee.m
//  iOS Assignment
//
//  Created by Hira Saleem on 28/07/2024.
//

#import "Employee.h"

@implementation Employee

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            _employeeID = dictionary[@"uuid"];
            _name = dictionary[@"full_name"];
            _team = dictionary[@"team"];
            _photoURL = dictionary[@"photo_url_small"];
            _phoneNumber = dictionary[@"phone_number"];
            _biography = dictionary[@"biography"];
            _email = dictionary[@"email_address"];
        }
    }
    return self;
}

@end
