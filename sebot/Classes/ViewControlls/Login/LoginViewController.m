//
//  LoginViewController.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForegetPasswordViewController.h"
#import "AFHttpClient.h"
#import "LoginModel.h"
#import "AFHttpClient+Account.h"
#import "BPush.h"
@interface LoginViewController ()
{
    NSMutableArray * datasouce;
}
@property (nonatomic,strong)UITextField * accountTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@end


@implementation LoginViewController

-(void)viewDidLoad{
    self.view.backgroundColor = NEW_GRAY_COLOR;
        datasouce = [NSMutableArray array];
    [self initUserface];
}

-(void)initUserface{
    

    UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake(122.5 * W_Wide_Zoom, 100 * W_Hight_Zoom, 130 * W_Wide_Zoom, 130 * W_Hight_Zoom)];
    icon.image = [UIImage imageNamed:@"APPImgae.png"];
    [self.view addSubview:icon];
    
    
    
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 300 * W_Hight_Zoom, 375 * W_Wide_Zoom, 100 * W_Hight_Zoom)];
    centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:centerView];
    
    NSArray * imagenameArray = @[@"user.png",@"password.png"];
    for (int i = 0 ; i < 3; i++) {
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + 50 * i * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [centerView addSubview:lineLabel];
        
        if (i < 2) {
    
        UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(30 * W_Wide_Zoom, 12.5 *  W_Hight_Zoom + i * 50 * W_Hight_Zoom, 25 * W_Wide_Zoom, 25 * W_Hight_Zoom)];
        //leftImage.backgroundColor = [UIColor greenColor];
        leftImage.image = [UIImage imageNamed:imagenameArray[i]];
        [centerView addSubview:leftImage];
        
        }
    
    }

    _accountTextfield = [[UITextField alloc]initWithFrame:CGRectMake(80 * W_Wide_Zoom, 10 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _accountTextfield.placeholder = NSLocalizedString(@"accountPlaceholder", nil);
    _accountTextfield.tintColor = GRAY_COLOR;
    _accountTextfield.textColor = [UIColor blackColor];
    _accountTextfield.font = [UIFont systemFontOfSize:15];
    [centerView addSubview:_accountTextfield];
    
    _passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(80 * W_Wide_Zoom, 60 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _passwordTextfield.placeholder = NSLocalizedString(@"passwordPlaceholder", nil);
    _passwordTextfield.tintColor = GRAY_COLOR;
    _passwordTextfield.textColor = [UIColor blackColor];
    _passwordTextfield.font = [UIFont systemFontOfSize:15];
    _passwordTextfield.secureTextEntry = YES;
    [centerView addSubview:_passwordTextfield];
    
    UIButton * loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 450 * W_Hight_Zoom, 345 * W_Wide_Zoom, 45 * W_Hight_Zoom)];
    loginBtn.backgroundColor = RED_COLOR;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn setTitle:NSLocalizedString(@"loginIn", nil) forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * newUserBtn = [[UIButton alloc]initWithFrame:CGRectMake(80 * W_Wide_Zoom, 630 * W_Hight_Zoom, 100 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    [newUserBtn setTitle:NSLocalizedString(@"newUser", nil) forState:UIControlStateNormal];
    [newUserBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    newUserBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:newUserBtn];
    [newUserBtn addTarget:self action:@selector(newuserTouch) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * forgetpasswordBtn = [[UIButton alloc]initWithFrame:CGRectMake(195 * W_Wide_Zoom, 630 * W_Hight_Zoom, 100 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    [forgetpasswordBtn setTitle:NSLocalizedString(@"forgetPassword", nil) forState:UIControlStateNormal];
    [forgetpasswordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forgetpasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:forgetpasswordBtn];
    [forgetpasswordBtn addTarget:self action:@selector(forgetpasswordTouch) forControlEvents:UIControlEventTouchUpInside];
    
    //查看密码的键
    UIButton * secureBtn = [[UIButton alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 68 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
    [secureBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
    [secureBtn setImage:[UIImage imageNamed:@"noshowpass.png"] forState:UIControlStateSelected];
    secureBtn.selected = YES;
    [secureBtn addTarget:self action:@selector(secureButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:secureBtn];

    
    
    
}
-(void)secureButtonTouch:(UIButton *)sender{
    
    _passwordTextfield.secureTextEntry = !_passwordTextfield.secureTextEntry;
    sender.selected = !sender.selected;
    
    
}


-(void)loginButtonTouch{
  //   NSString *myChannel_id = [BPush getChannelId];
    
    NSUserDefaults * defaltus = [NSUserDefaults standardUserDefaults];
    NSString * strrr = [defaltus objectForKey:@"changeid"];

    [self showHudInView:self.view hint:@"正在登录..."];
    [[AFHttpClient sharedAFHttpClient]loginWithUserName:_accountTextfield.text password:_passwordTextfield.text userid:@"" channelid:strrr complete:^(ResponseModel *model) {
        //判断是否绑定
        if (model) {
            
            NSString * content = model.content;
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:content forKey:@"isContent"];
            
            //存数据
            LoginModel * loginModel = [[LoginModel alloc]initWithDictionary:model.retVal error:nil];
            
            [[AccountManager sharedAccountManager] login:loginModel];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
            [self updatePhone];
            [self hideHud];
        }else{
            
        }
    
    }];
    [self hideHud];

}


/**
 *  更新手机推送标识
 */


- (void)updatePhone
{
    // NSString *myChannel_id = [BPush getChannelId];
    NSUserDefaults * defaltus = [NSUserDefaults standardUserDefaults];
    NSString * strrr = [defaltus objectForKey:@"changeid"];
     NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
    [[AFHttpClient  sharedAFHttpClient]updatephone:str token:str channelid:strrr type:@"ios" complete:^(ResponseModel * model) {
        
    }];
    
    
}




-(void)newuserTouch{
    RegistViewController * regist = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:regist animated:NO];


}

-(void)forgetpasswordTouch{
    ForegetPasswordViewController * forVc = [[ForegetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forVc animated:NO];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}


@end