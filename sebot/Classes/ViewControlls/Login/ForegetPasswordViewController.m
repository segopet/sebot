//
//  ForegetPasswordViewController.m
//  sebot
//
//  Created by czx on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ForegetPasswordViewController.h"
#import "AFHttpClient+Regist.h"

@interface ForegetPasswordViewController ()
@property (nonatomic,strong)UIButton * achieveSecurityBtn;
@property (nonatomic,strong)UITextField * phoneNumberTextfield;
@property (nonatomic,strong)UITextField * achieveTextfield;
@property (nonatomic,strong)UITextField * passwordTextfield;
@property (nonatomic,strong)UITextField * surePasswordTextfield;
@property (nonatomic,copy)NSString * achieveString;
@property (nonatomic,copy)NSString * surePhonenumber;

@property (nonatomic,strong)UIButton * passBtn;
@property (nonatomic,strong)UIButton * suerPassBtn;
@end

@implementation ForegetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NEW_GRAY_COLOR;
    [self setNavTitle:@"忘记密码"];
    [UINavigationBar appearance].barTintColor=RED_COLOR;
    [self initUserface];
}
-(void)initUserface{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 68 * W_Hight_Zoom, 375 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray * namearray = @[NSLocalizedString(@"phoneNumber", nil),NSLocalizedString(@"yanzhengma", nil),NSLocalizedString(@"password", nil),NSLocalizedString(@"surePassword", nil)];
    for (int i = 0 ; i < 4 ; i++ ) {
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 50 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = GRAY_COLOR;
        [topView addSubview:lineLabel];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 15 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 80 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
        nameLabel.text = namearray[i];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont systemFontOfSize:14];
        [topView addSubview:nameLabel];
    }
    
    _achieveSecurityBtn = [[UIButton alloc]initWithFrame:CGRectMake(260 * W_Wide_Zoom, 60 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _achieveSecurityBtn.backgroundColor = RED_COLOR;
    [_achieveSecurityBtn setTitle:NSLocalizedString(@"getSecurity", nil) forState:UIControlStateNormal];
    _achieveSecurityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_achieveSecurityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _achieveSecurityBtn.layer.cornerRadius = 5;
    [topView addSubview:_achieveSecurityBtn];
    [_achieveSecurityBtn addTarget:self action:@selector(yanzhengmaTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(15 * W_Wide_Zoom, 300 * W_Hight_Zoom, 345 * W_Wide_Zoom, 45 * W_Hight_Zoom)];
    doneBtn.backgroundColor = RED_COLOR;
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.layer.cornerRadius = 5;
    [self.view addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(registButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    

    _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 11 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    //_phoneNumberTextfield.backgroundColor = [UIColor redColor];
    _phoneNumberTextfield.placeholder = NSLocalizedString(@"accountPlaceholder", nil);
    _phoneNumberTextfield.tintColor = GRAY_COLOR;
    _phoneNumberTextfield.textColor = [UIColor blackColor];
    _phoneNumberTextfield.font = [UIFont systemFontOfSize:14];
    [topView addSubview:_phoneNumberTextfield];
    
    _achieveTextfield = [[UITextField alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 61 * W_Hight_Zoom, 150 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _achieveTextfield.placeholder = @"请输入验证码";
    _achieveTextfield.tintColor = GRAY_COLOR;
    _achieveTextfield.textColor = [UIColor blackColor];
    _achieveTextfield.font = [UIFont systemFontOfSize:14];
    [topView addSubview:_achieveTextfield];
    
    _passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 111 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _passwordTextfield.placeholder = @"请输入密码";
    _passwordTextfield.tintColor = GRAY_COLOR;
    _passwordTextfield.textColor = [UIColor blackColor];
    _passwordTextfield.font = [UIFont systemFontOfSize:14];
    _passwordTextfield.secureTextEntry = YES;
    [topView addSubview:_passwordTextfield];
    
    _surePasswordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(100 * W_Wide_Zoom, 161 * W_Hight_Zoom, 200 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _surePasswordTextfield.placeholder = @"请输入密码";
    _surePasswordTextfield.tintColor = GRAY_COLOR;
    _surePasswordTextfield.textColor= [UIColor blackColor];
    _surePasswordTextfield.font = [UIFont systemFontOfSize:14];
    _surePasswordTextfield.secureTextEntry = YES;
    [topView addSubview:_surePasswordTextfield];
    
    _passBtn = [[UIButton alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 118 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
    [_passBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
    [_passBtn setImage:[UIImage imageNamed:@"noshowpass.png"] forState:UIControlStateSelected];
    _passBtn.selected = YES;
    [topView addSubview:_passBtn];
    [_passBtn addTarget:self action:@selector(passbuttontouch) forControlEvents:UIControlEventTouchUpInside];
    
    _suerPassBtn = [[UIButton alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 168 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
    [_suerPassBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
    [_suerPassBtn setImage:[UIImage imageNamed:@"noshowpass.png"] forState:UIControlStateSelected];
    _suerPassBtn.selected = YES;
    [topView addSubview:_suerPassBtn];
    [_suerPassBtn addTarget:self action:@selector(passbuttontouch) forControlEvents:UIControlEventTouchUpInside];


}
-(void)passbuttontouch{
    _passBtn.selected = !_passBtn.selected;
    _suerPassBtn.selected = !_suerPassBtn.selected;
    _passwordTextfield.secureTextEntry = !_passwordTextfield.secureTextEntry;
    _surePasswordTextfield.secureTextEntry = !_surePasswordTextfield.secureTextEntry;
    
}





-(void)yanzhengmaTouch{
    if ([AppUtil isBlankString:_phoneNumberTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入账号"];
        return;
    }
    if (![AppUtil isValidateMobile:_phoneNumberTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确格式的手机号码"];
        return;
    }
    [self provied];
}
-(void)provied{
    [self timeout];

        [[AFHttpClient sharedAFHttpClient]provedWithUserid:@"" token:@"" phone:_phoneNumberTextfield.text type:@"modifypassword" complete:^(ResponseModel *model) {
            if (model) {
                _achieveString = model.content;
                _surePhonenumber = model.retDesc;
            }
            
        }];
    
}




//忘记密码
-(void)registButtonTouch:(UIButton *)sender{
   
    if ([AppUtil isBlankString:_phoneNumberTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入账号"];
        return;
    }
    if (![AppUtil isValidateMobile:_phoneNumberTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确格式的手机号码"];
        return;
    }
    if ([AppUtil isBlankString:_achieveTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入验证码"];
        return;
    }
    if ([AppUtil isBlankString:_passwordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入密码"];
        return;
    }
    if (![_passwordTextfield.text isEqualToString:_surePasswordTextfield.text]) {
        [[AppUtil appTopViewController] showHint:@"两次输入密码不一致"];
        return;
    }
    if (![_achieveTextfield.text isEqualToString:_achieveString]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确的验证码"];
        return;
    }
    if (![_phoneNumberTextfield.text isEqualToString:_surePhonenumber]) {
        [[AppUtil appTopViewController] showHint:@"手机号码错误"];
        return;
    }
     sender.userInteractionEnabled = NO;
    [self showHudInView:self.view hint:@"正在修改..."];
    [[AFHttpClient sharedAFHttpClient]forgetPasswordWithPhone:_phoneNumberTextfield.text password:_passwordTextfield.text complete:^(ResponseModel *model) {
        if (model) {
            
            sender.userInteractionEnabled = YES;
             [[AppUtil appTopViewController] showHint:model.retDesc];
            [self.navigationController popViewControllerAnimated:NO];
        }
         [self hideHud];
    }];
    
    
    
    
}

- (void)timeout
{
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);     dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_achieveSecurityBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _achieveSecurityBtn.userInteractionEnabled = YES;
                _achieveSecurityBtn.backgroundColor = RED_COLOR;
            });
        }else{
            //int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%0.2d", timeout];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //  NSLog(@"————————%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_achieveSecurityBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _achieveSecurityBtn.userInteractionEnabled = NO;
                _achieveSecurityBtn.backgroundColor = [UIColor grayColor];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}




@end