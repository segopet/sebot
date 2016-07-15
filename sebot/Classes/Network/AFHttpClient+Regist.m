//
//  AFHttpClient+Regist.m
//  sebot
//
//  Created by czx on 16/7/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Regist.h"

@implementation AFHttpClient (Regist)

-(void)provedWithUserid:(NSString *)userid token:(NSString *)token  phone:(NSString *)phone type:(NSString *)type complete:(void (^)(ResponseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        params[@"userid"] = userid;
        params[@"token"] = token;
        params[@"objective"] = @"user";
        params[@"action"] = @"getCode";
        //data里面传的东西
        NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
        dataParams[@"phone"] = phone;
        dataParams[@"type"] = type;
        params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(ResponseModel *model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];





}

@end
