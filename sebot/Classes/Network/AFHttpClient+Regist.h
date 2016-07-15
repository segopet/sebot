//
//  AFHttpClient+Regist.h
//  sebot
//
//  Created by czx on 16/7/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Regist)
//验证码
- (void)provedWithUserid:(NSString*)userid token:(NSString*)token phone:(NSString *)phone type:(NSString *)type complete:(void(^)(ResponseModel *model))completeBlock;

//注册
-(void)registWithphone:(NSString *)phone password:(NSString *)password complete:(void(^)(ResponseModel *model))completeBlock;


//忘记密码
-(void)forgetPasswordWithPhone:(NSString *)phone password:(NSString *)password complete:(void(^)(ResponseModel *model))completeBlock;




@end
