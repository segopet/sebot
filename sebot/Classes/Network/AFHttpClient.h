//
//  AFHttpClient.h
//  sebot
//
//  Created by ldp on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "BaseModel.h"
#import "LoginModel.h"
@interface AFHttpClient : AFHTTPSessionManager

singleton_interface(AFHttpClient)


/**
 *  请求的Post方法
 *
 */
- (void)POST:(NSString *)URLString  parameters:(id)parameters result:(void (^)(id model))result;

- (void)test;



@end
