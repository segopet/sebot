//
//  AFHttpClient+Test.h
//  sebot
//
//  Created by czx on 16/7/4.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Test)
-(void)testWithuserid:(NSString *)userid token:(NSString *)token complete:(void(^)(ResponseModel *model))completeBlock;

-(void)newphotoWithUserid:(NSString *)userid token:(NSString *)token complete:(void(^)(ResponseModel *model))completeBlock;

/**
 *  我的设备
 */
-(void)checkmoel:(NSString *)userid token:(NSString *)token complete:(void (^)(ResponseModel *))completeBlock;


@end
