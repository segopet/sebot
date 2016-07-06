//
//  AFHttpClient+FamilyTeam.h
//  sebot
//
//  Created by yulei on 16/7/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (FamilyTeam)

/**
 *  家庭成员
 */
-(void)familyteam:(NSString *)userid token:(NSString *)token  did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock;

/**
 *  转让
 */

-(void)givePowr:(NSString *)userid token:(NSString *)token  admin:(NSString *)admin usr:(NSString* )usr did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock;


/**
 *  移除
 */

-(void)move:(NSString *)userid token:(NSString *)token  admin:(NSString *)admin usr:(NSString* )usr did:(NSString *)did complete:(void (^)(ResponseModel *))completeBlock;


/**
 *  邀请
 */

-(void)invate:(NSString *)userid token:(NSString *)token  admin:(NSString *)admin phone:(NSString* )phone deviceno:(NSString *)deviceno complete:(void (^)(ResponseModel *))completeBlock;


@end
