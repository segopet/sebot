//
//  AFHttpClient+Alumb.m
//  sebot
//
//  Created by czx on 16/7/7.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Alumb.h"

@implementation AFHttpClient (Alumb)
-(void)issueWithuserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid coneten:(NSString *)content photos:(NSMutableString *)photos complete:(void (^)(ResponseModel *))completeBlock{
    
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"upload";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"aid"] = aid;
    dataparms[@"content"] = content;
    dataparms[@"photos"] = photos;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        
        if (model) {
            completeBlock(model);
        }
        
    }];
}

-(void)familyArticlesWithUserid:(NSString *)userid token:(NSString *)token page:(NSString *)page complete:(void (^)(ResponseModel *))completeBlock{
    
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"articles";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"page"] = page;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [FamilyquanModel arrayOfModelsFromDictionaries:model.list];
        if (model) {
            completeBlock(model);
        }
        
    }];
}

-(void)dianzanWithUserid:(NSString *)userid token:(NSString *)token objid:(NSString *)objid objtype:(NSString *)objtype complete:(void (^)(ResponseModel *))completeBlock{

    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"addBehavior";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"objid"] = objid;
    dataparms[@"objtype"] = objtype;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
    if (model) {
            completeBlock(model);
        }
    }];
}

-(void)lookpictureWithUserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid complete:(void (^)(ResponseModel *))completeBlock{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"articlePics";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"aid"] = aid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        if (model) {
            completeBlock(model);
        }
    }];


}












@end
