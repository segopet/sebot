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



@end
