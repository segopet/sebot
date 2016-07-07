//
//  AFHttpClient+Person.m
//  sebot
//
//  Created by yulei on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Person.h"
#import "PersonModel.h"

@implementation AFHttpClient (Person)


/**
 *  设备信息
 */
-(void)deciveInforamtion:(NSString *)userid token:(NSString *)token  complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"user";
    parms[@"action"] = @"queryUser";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}



-(void)updateHead:(NSString *)userid token:(NSString *)token image:(NSString * )image complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"user";
    parms[@"action"] = @"modifyHeadportrait";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"images"] = image;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}

@end
