//
//  AFHttpClient+About.m
//  sebot
//
//  Created by czx on 16/7/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+About.h"

@implementation AFHttpClient (About)
-(void)xieyiWithuserid:(NSString *)userid token:(NSString *)token complete:(void (^)(ResponseModel * model))completeBlock{
    NSMutableDictionary * parms = [[NSMutableDictionary alloc]init];
    parms[@"userid"] = userid;
    parms[@"token"] = token;
    parms[@"objective"] = @"agreement";
    parms[@"action"] = @"agreement";
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    parms[@"data"] = dataParams;
    
    [self POST:@"/sebot/common/forward" parameters:parms result:^(ResponseModel * model) {
        
        if (model) {
            completeBlock(model);
        }
        
    }];

}


@end
