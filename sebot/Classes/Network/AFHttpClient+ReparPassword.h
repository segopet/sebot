//
//  AFHttpClient+ReparPassword.h
//  sebot
//
//  Created by yulei on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (ReparPassword)

/**
 *  修改密码
 */
-(void)repairPs:(NSString *)userid token:(NSString *)token old:(NSString * )old new:(NSString *)newPs complete:(void (^)(ResponseModel *))completeBlock;

@end
