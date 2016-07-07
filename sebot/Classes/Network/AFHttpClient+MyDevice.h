//
//  AFHttpClient+MyDevice.h
//  sebot
//
//  Created by czx on 16/7/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (MyDevice)
/**
 *  我的设备
 */
-(void)checkmoel:(NSString *)userid token:(NSString *)token complete:(void (^)(ResponseModel *))completeBlock;

/**
 *  添加设备
 */
-(void)addDevide:(NSString *)userid token:(NSString *)token deviceno:(NSString *)deviceno complete:(void (^)(ResponseModel *))completeBlock;

@end
