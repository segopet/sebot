//
//  AFHttpClient+ReparPassword.m
//  sebot
//
//  Created by yulei on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+ReparPassword.h"

@implementation AFHttpClient (ReparPassword)

-(void)repairPs:(NSString *)userid token:(NSString *)token old:(NSString * )old new:(NSString *)newPs complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"user";
    parms[@"action"] = @"modifyPassword";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"oldpassword"]= old;
    dataparms[@"newpassword"] = newPs;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}

@end
