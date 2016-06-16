//
//  LoginViewController.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong)UITextField * accountTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@end


@implementation LoginViewController

-(void)viewDidLoad{
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [self initUserface];
}

-(void)initUserface{
    
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 200 * W_Hight_Zoom, 375 * W_Wide_Zoom, 100 * W_Hight_Zoom)];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    
    for (int i = 0 ; i < 3; i++) {
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + 50 * i * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [centerView addSubview:lineLabel];
        
        if (i < 2) {
    
        UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(30 * W_Wide_Zoom, 12.5 *  W_Hight_Zoom + i * 50 * W_Hight_Zoom, 25 * W_Wide_Zoom, 25 * W_Hight_Zoom)];
        leftImage.backgroundColor = [UIColor greenColor];
        [centerView addSubview:leftImage];
        
        }
    
    }

    _accountTextfield = [[UITextField alloc]initWithFrame:CGRectMake(80 * W_Wide_Zoom, 10 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _accountTextfield.placeholder = @"请输入帐号";
    _accountTextfield.tintColor = GRAY_COLOR;
    _accountTextfield.textColor = [UIColor blackColor];
    _accountTextfield.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:_accountTextfield];
    
    _passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(80 * W_Wide_Zoom, 60 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _passwordTextfield.placeholder = @"请输入密码";
    _passwordTextfield.tintColor = GRAY_COLOR;
    _passwordTextfield.textColor = [UIColor blackColor];
    _passwordTextfield.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:_passwordTextfield];
    
    
    

}






@end