//
//  AFHttpClient+Test.m
//  sebot
//
//  Created by czx on 16/7/4.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Test.h"

@implementation AFHttpClient (Test)
-(void)testWithuserid:(NSString *)userid token:(NSString *)token complete:(void (^)(BaseModel *))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"album";
    parms[@"action"] = @"mydevices";
    NSMutableDictionary * dataparms = [[NSMutableDictionary alloc]init];
    dataparms[@"userid"] = userid;
    parms[@"data"] =dataparms;
    
    [self POST:@"sebot/moblie/forward" parameters:parms result:^(BaseModel * model) {
        model.list = [NewAlbumAdviceModel arrayOfModelsFromDictionaries:model.list];
    }];
    
    
    
    
}





@end
