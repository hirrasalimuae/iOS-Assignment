//
//  NetworkManager.h
//  NetworkManagerFramework
//
//  Created by Hira Saleem on 28/07/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessHandler)(NSData *data);
typedef void(^FailureHandler)(NSError *error);

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;
- (void)getDataFromURL:(NSURL *)url
               success:(SuccessHandler)success
               failure:(FailureHandler)failure;

@end

NS_ASSUME_NONNULL_END
