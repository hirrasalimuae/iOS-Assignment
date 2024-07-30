//
//  NetworkManager.m
//  NetworkManagerFramework
//
//  Created by Hira Saleem on 28/07/2024.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)getDataFromURL:(NSURL *)url
               success:(SuccessHandler)success
               failure:(FailureHandler)failure {
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(data);
        }
    }];
    [dataTask resume];
}

@end
