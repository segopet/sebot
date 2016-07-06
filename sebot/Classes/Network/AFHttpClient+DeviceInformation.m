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
@end
