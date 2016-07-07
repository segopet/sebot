//
//  AFHttpClient+FamilyTeam.m
//  sebot
//
//  Created by yulei on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+FamilyTeam.h"
#import "FamilyTeamModel.h"

@implementation AFHttpClient (FamilyTeam)

-(void)familyteam:(NSString *)userid token:(NSString *)token  did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"queryFamilyMember";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    dataparms[@"did"]= did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [FamilyTeamModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

}


-(void)givePowr:(NSString *)userid token:(NSString *)token  admin:(NSString *)admin usr:(NSString* )usr did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"transfer";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"admin"] = admin;
    dataparms[@"userid"]= usr;
    dataparms[@"did"]= did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [FamilyTeamModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
    
}

-(void)move:(NSString *)userid token:(NSString *)token  admin:(NSString *)admin usr:(NSString* )usr did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"remove";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"admin"] = admin;
    dataparms[@"userid"]= usr;
    dataparms[@"did"]= did;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [FamilyTeamModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}


-(void)invate:(NSString *)userid token:(NSString *)token  admin:(NSString *)admin phone:(NSString* )phone deviceno:(NSString *)deviceno complete:(void (^)(ResponseModel *))completeBlock

{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"device";
    parms[@"action"] = @"inviteRequest";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = admin;
    dataparms[@"phone"]= phone;
    dataparms[@"deviceno"]= deviceno;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [FamilyTeamModel arrayOfModelsFromDictionaries:model.list];
        
        if (model) {
            completeBlock(model);
        }
        
    }];

    
    
}

@end
