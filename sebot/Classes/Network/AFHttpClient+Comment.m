//
//  AFHttpClient+Comment.m
//  sebot
//
//  Created by czx on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Comment.h"

@implementation AFHttpClient (Comment)
-(void)quserCommentWithUserid:(NSString *)userid token:(NSString *)token wid:(NSString *)wid ptype:(NSString *)ptype page:(NSString *)page complete:(void (^)(ResponseModel *))completeBlock{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = userid;
    params[@"token"] = token;
    params[@"objective"] = @"album";
    params[@"action"] = @"queryComment";
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"wid"] = wid;
    dataParams[@"ptype"] = ptype;
    dataParams[@"page"] = page;
    params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(ResponseModel *model) {
        
        if (model) {
            model.list = [CommentModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
        
    }];


}




-(void)addCommentWithUserid:(NSString *)userid token:(NSString *)token pid:(NSString *)pid bid:(NSString *)bid wid:(NSString *)wid bcid:(NSString *)bcid ptype:(NSString *)ptype action:(NSString *)action content:(NSString *)content complete:(void (^)(ResponseModel *))completeBlock{






}

@end
