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


/*
 * 编辑相册
 */
-(void)compliePhoto:(NSString *)userid token:(NSString *)token albumname:(NSString *)albumname dids:(NSString *)dids aid:(NSString *)aid complete:(void(^)(ResponseModel *model))completeBlock;
/*
 * 删除相册
 */

-(void)delePhoto:(NSString *)userid token:(NSString *)token  aid:(NSString *)aid complete:(void(^)(ResponseModel *model))completeBlock;


/*
 * 编辑相册
 */

-(void)albumdetail:(NSString *)userid token:(NSString *)token  aid:(NSString *)aid complete:(void(^)(ResponseModel *model))completeBlock;


@end
