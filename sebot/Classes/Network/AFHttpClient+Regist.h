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

//-(void)provedWithUserid:(NSString *)userid token:(NSString *)token phone:(NSString *)phone type:(NSString *)type complete:(void (^)(ResponseModel * model))completeBlock;
- (void)provedWithUserid:(NSString*)userid token:(NSString*)token phone:(NSString *)phone type:(NSString *)type complete:(void(^)(ResponseModel *model))completeBlock;



@end
