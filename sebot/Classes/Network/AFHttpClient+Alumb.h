//
//  AFHttpClient+Alumb.h
//  sebot
//
//  Created by czx on 16/7/7.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Alumb)
//上传图片
-(void)issueWithuserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid coneten:(NSString *)content photos:(NSMutableString *)photos userides:(NSString *)userids complete:(void(^)(ResponseModel *model))completeBlock;

//家庭圈详情
-(void)familyArticlesWithUserid:(NSString *)userid token:(NSString *)token
                           page:(NSString *)page complete:(void(^)(ResponseModel *model))completeBlock;

//点赞
-(void)dianzanWithUserid:(NSString *)userid token:(NSString *)token objid:(NSString *)objid objtype:(NSString *)objtype complete:(void(^)(ResponseModel *model))completeBlock;

//查看照片
-(void)lookpictureWithUserid:(NSString *)userid token:(NSString *)token aid:(NSString *)aid complete:(void(^)(ResponseModel *model))completeBlock;


//通过我的设备的接口来判断是否绑定了设备
-(void)querMydeviceWithUserid:(NSString *)userid token:(NSString * )token complete:(void(^)(ResponseModel *model))completeBlock;






@end
