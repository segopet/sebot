//
//  AFHttpClient+DeviceInformation.h
//  sebot
//
//  Created by yulei on 16/7/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (DeviceInformation)

/**
 *  设备信息
 */
-(void)deciveInforamtion:(NSString *)userid token:(NSString *)token did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock;


/**
 *  修改备注
 */
-(void)repairName:(NSString *)userid token:(NSString *)token did:(NSString *)did remark:(NSString *)remark complete:(void (^)(ResponseModel *))completeBlock;


/**
 *  解绑
 */

-(void)solvDevice:(NSString *)userid token:(NSString *)token did:(NSString *)did  complete:(void (^)(ResponseModel *))completeBlock;

/**
 *  添加设备使用记录
 */

-(void)solvDevice:(NSString *)userid token:(NSString *)token call:(NSString *)calling  called:(NSString *)called object:(NSString *)object complete:(void (^)(ResponseModel *))completeBlock;


/**
 *  更新设备使用记录
 */

-(void)updateDevice:(NSString *)userid token:(NSString *)token  did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock;


@end
