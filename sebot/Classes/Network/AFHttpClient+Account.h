//
//  AFHttpClient+Account.h
//  petegg
//
//  Created by ldp on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient.h"

@interface AFHttpClient (Account)



- (void)loginWithUserName:(NSString*)userName password:(NSString*)password userid:(NSString *)userid complete:(void(^)(ResponseModel *model))completeBlock;




/**
 *  更新手机推送标识
 */

-(void)updatephone:(NSString *)userid token:(NSString *)token  channelid:(NSString *)channelid type:(NSString *)type complete:(void (^)(ResponseModel * model))completeBlock;

@end
