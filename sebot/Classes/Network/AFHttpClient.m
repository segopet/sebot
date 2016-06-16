//
//  AFHttpClient.m
//  sebot
//
//  Created by ldp on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@implementation AFHttpClient

singleton_implementation(AFHttpClient)

- (instancetype)init {
    if (self = [super initWithBaseURL:[NSURL URLWithString:BASE_URL]]) {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain", @"application/json", nil];
        
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                    
                    break;
                default:
                    break;
            }
        }];
        [self.reachabilityManager startMonitoring];
    }
    return self;
}


- (void)POST:(NSString *)URLString parameters:(id)parameters result:(void (^)(id model))result {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (parameters) {
            NSString* paramsStr = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]  encoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:[paramsStr dataUsingEncoding:NSUTF8StringEncoding] name:@"rp"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if ([responseObject[@"retCode"] isEqualToString:@"SUCCESS"]) {
            if (result) {
                result(responseObject);
            }
        }else{

            [[AppUtil appTopViewController] showHint:responseObject[@"retDesc"]];
            
            if (result) {
                result(nil);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (result) {
            result(nil);
        }
    }];
    
}

- (void)test {
    
    [self POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"token" : @"1" , @"objective" : @"user" , @"action" : @"queryUser", @"data" : @{@"userid" : @"1"}} result:^(id model) {
        
        NSLog(@"%@", model);
        
    } ];
    
}

@end
