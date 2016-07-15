//
//  AFHttpClient+Person.h
//  sebot
//
//  Created by yulei on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Person)

/**
 *  个人信息
 */
-(void)deciveInforamtion:(NSString *)userid token:(NSString *)token  complete:(void (^)(ResponseModel *))completeBlock;

/**
 *  上传头像
 */
-(void)updateHead:(NSString *)userid token:(NSString *)token image:(NSString * )image complete:(void (^)(ResponseModel *))completeBlock;

/**
 *  修改昵称
 */

-(void)repairname:(NSString *)userid token:(NSString *)token nickname:(NSString * )nickname complete:(void (^)(ResponseModel *))completeBlock;

@end
