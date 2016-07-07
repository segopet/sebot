//
//  AFHttpClient+DeviceInformation.m
//  sebot
//
//  Created by yulei on 16/7/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+DeviceInformation.h"

@implementation AFHttpClient (DeviceInformation)

-(void)deciveInforamtion:(NSString *)userid token:(NSString *)token did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock
{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"queryByIdDeviceInfo";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] =did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}

-(void)repairName:(NSString *)userid token:(NSString *)token did:(NSString *)did remark:(NSString *)remark complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"modifyDeviceRemark";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] =did;
    dataparms[@"remark"]= remark;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}

-(void)solvDevice:(NSString *)userid token:(NSString *)token did:(NSString *)did  complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"unbundling";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"] =did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    
}

-(void)solvDevice:(NSString *)userid token:(NSString *)token call:(NSString *)calling  called:(NSString *)called object:(NSString *)object complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"addCallRecords";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"called"] = called;
    dataparms[@"calling"] =calling;
    dataparms[@"object"] = object;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [CheckDeviceModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}
@end
