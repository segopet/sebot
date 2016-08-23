//
//  AFHttpClient+Videomessage.m
//  sebot
//
//  Created by czx on 16/8/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Videomessage.h"

@implementation AFHttpClient (Videomessage)
-(void)getVideomessageWithUserid:(NSString *)userid token:(NSString *)token page:(NSString *)page complete:(void (^)(ResponseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = userid;
    params[@"token"] = token;
    params[@"objective"] = @"user";
    params[@"action"] = @"videoMsg";
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"userid"] = userid;
    dataParams[@"page"] = page;
    params[@"data"] = dataParams;
    [self POST:@"sebot/moblie/forward" parameters:params result:^(ResponseModel *model) {
        
        if (model) {
            model.list = [VideoMessageModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    }];
    












}
@end
