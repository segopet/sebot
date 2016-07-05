//
//  AFHttpClient+Account.m
//  petegg
//
//  Created by ldp on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Account.h"

@implementation AFHttpClient (Account)

-(void)loginWithUserName:(NSString *)userName password:(NSString *)password userid:(NSString *)userid complete:(void (^)(ResponseModel *))completeBlock{

//     [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid":@"",@"token":@"",@"objective":@"user",@"action":@"login",@"data":@{@"accountnumber":_accountTextfield.text,@"password":_passwordTextfield.text,@"model":@"6s",@"brand":@"6s",@"version":@"9.3.2",@"type":@"ios",@"channelid":@""}} result:^(BaseModel * model) {
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    params[@"userid"] = userid;
    params[@"token"] = userid;
    params[@"objective"] = @"user";
    params[@"action"] = @"login";
    //data里面传的东西
    NSMutableDictionary * dataParams = [[NSMutableDictionary alloc]init];
    dataParams[@"accountnumber"] = userName;
    dataParams[@"password"] = password;
    dataParams[@"model"] = @"6s";
    dataParams[@"brand"] = @"6s";
    dataParams[@"version"] = @"9.3";
    dataParams[@"type"] = @"ios";
    dataParams[@"channelid"] = @"";
    
    params[@"data"] = dataParams;
    
    [self POST:@"sebot/moblie/forward" parameters:params result:^(ResponseModel *model) {
       //model.retVal = [LoginModel ？？];
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    






}





@end
