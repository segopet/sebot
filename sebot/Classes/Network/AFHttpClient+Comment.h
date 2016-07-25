//
//  AFHttpClient+Comment.h
//  sebot
//
//  Created by czx on 16/7/20.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Comment)
//查询评论
-(void)quserCommentWithUserid:(NSString *)userid token:(NSString *)token wid:(NSString *)wid ptype:(NSString *)ptype page:(NSString *)page complete:(void(^)(ResponseModel *model))completeBlock;


//添加评论
-(void)addCommentWithUserid:(NSString *)userid token:(NSString *)token pid:(NSString *)pid bid:(NSString *)bid wid:(NSString *)wid bcid:(NSString *)bcid ptype:(NSString *)ptype action:(NSString *)action content:(NSString *)content type:(NSString *)type complete:(void(^)(ResponseModel *model))completeBlock;




@end
