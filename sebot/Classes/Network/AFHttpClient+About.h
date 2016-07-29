//
//  AFHttpClient+About.h
//  sebot
//
//  Created by czx on 16/7/29.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (About)
//注册协议
-(void)xieyiWithuserid:(NSString *)userid token:(NSString *)token complete:(void (^)(ResponseModel * model))completeBlock;





@end
