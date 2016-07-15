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



-(void)registWithphone:(NSString *)phone password:(NSString *)password complete:(void (^)(ResponseModel *))completeBlock{

    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = @"";
    params[@"token"] = @"";
    params[@"objective"] = @"user";
    params[@"action"] = @"register";
    //data里面传的东西
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"phone"] = phone;
    dataParams[@"password"] = password;
    params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(ResponseModel *model) {
        if (model) {
            completeBlock(model);
        }
        NSLog(@"%@",model);
    }];

}



-(void)forgetPasswordWithPhone:(NSString *)phone password:(NSString *)password complete:(void (^)(ResponseModel *))completeBlock{
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = @"";
    params[@"token"] = @"";
    params[@"objective"] = @"user";
    params[@"action"] = @"forgetPassword";
    //data里面传的东西
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"phone"] = phone;
    dataParams[@"password"] = password;
    params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(ResponseModel *model) {
        if (model) {
            completeBlock(model);
        }
        NSLog(@"%@",model);
    }];

}







@end
