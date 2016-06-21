//
//  AFHttpClient+Account.m
//  petegg
//
//  Created by ldp on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Account.h"

@implementation AFHttpClient (Account)



-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void (^)(BaseModel *))completeBlock{
    
//    NSMutableDictionary* params = [NSMutableDictionary dictionary];
//    
//    params[@"common"] = @"memberLogin";
//    
//    params[@"accountnumber"] = userName;
//    params[@"password"] = password;
//    
//    params[@"model"] = [[UIDevice currentDevice] model];
//    params[@"brand"] = @"iphone";
//    params[@"version"] = [[UIDevice currentDevice] systemVersion];
//    params[@"imei"] = @"";
//    params[@"imsi"] = @"";
//    params[@"type"] = @"ios";

    [self POST:@"clientAction.do" parameters:@{@"userid":@"",@"token":@"",@"objective":@"user",@"action":@"login",@"data":@{@"accountnumber":userName,@"password":password,@"model":@"6s",@"brand":@"6s",@"version":@"9.3.2",@"type":@"ios",@"channelid":@""}} result:^(BaseModel *model) {
        if (model){
   // model.retVal = [LoginModel arrayOfModelsFromDictionaries:model.list];
        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];





}



@end
