//
//  AFHttpClient+MyPhoto.m
//  sebot
//
//  Created by yulei on 16/7/19.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+MyPhoto.h"
#import "PhotoModel.h"

@implementation AFHttpClient (MyPhoto)



-(void)QueryMyPhoto:(NSString *)userid token:(NSString *)token complete:(void (^)(ResponseModel *))completeBlock
{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"queryAlbum";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        model.list = [NewAlbumModel arrayOfModelsFromDictionaries:model.list];
        if (model) {
            completeBlock(model);
        }
        
    }];

    
}

-(void)QueryMyPhotos:(NSString *)userid token:(NSString *)token did:(NSString *)did page:(NSString *)page complete:(void (^)(ResponseModel *))completeBlock
{
    
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"queryPhoto";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"aid"] = did;
    dataparms[@"page"] = page;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
         model.list = [PhotoModel arrayOfModelsFromDictionaries:model.list];
        if (model) {
            completeBlock(model);
        }
        
    }];
    
}

-(void)Deletephoto:(NSString *)userid token:(NSString *)token pids:(NSString *)pids complete:(void (^)(ResponseModel *))completeBlock
{
    
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"deletePhoto";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"pids"] = pids;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(ResponseModel * model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];
    
    
}

@end
