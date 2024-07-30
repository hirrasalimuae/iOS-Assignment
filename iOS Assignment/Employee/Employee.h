//
//  Employee.h
//  iOS Assignment
//
//  Created by Hira Saleem on 28/07/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSObject

@property (nonatomic, strong) NSString *employeeID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *team;
@property (nonatomic, strong) NSString *photoURL;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) NSString *email;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
