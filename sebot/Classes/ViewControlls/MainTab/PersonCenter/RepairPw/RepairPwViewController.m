//
//  RepairPwViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RepairPwViewController.h"
#import "AFHttpClient+ReparPassword.h"
#import "LoginViewController.h"

@interface RepairPwViewController ()

@end

@implementation RepairPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavTitle: NSLocalizedString(@"RepairPw", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    self.updateBtn.backgroundColor =  RED_COLOR ;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupView
{
    [super setupView];
    
    
    
}


// 提交
- (IBAction)updateBtn:(UIButton *)sender {
    
    
    
//    if ([self.oldPsTx.text  isEqualToString:@""] || [self.NewPsTx.text isEqualToString:@"" ] || [self.ageinNewPsTx.text isEqualToString:@"" ]) {
//        
//        
//        [self showSuccessHudWithHint:@"不能为空"];
//        return;
//    }
    if ([AppUtil isBlankString:self.oldPsTx.text]) {
         [self showSuccessHudWithHint:@"请输入旧密码"];
        return;
    
    }
    
    if (![self.oldPsTx.text isEqualToString:[AccountManager sharedAccountManager].loginModel.password])
    {
        [self showSuccessHudWithHint:@"旧密码输入错误"];
        return;
    }
    
    if ([AppUtil isBlankString:self.NewPsTx.text]) {
        [self showSuccessHudWithHint:@"请输入新密码"];
        return;
    }
    
 
    if ([self.oldPsTx.text isEqualToString:self.NewPsTx.text]) {
        [self showSuccessHudWithHint:@"旧密码与新密码不能相同"];
        return;
        
    }
    
    if (![self.NewPsTx.text isEqualToString:self.ageinNewPsTx.text]) {
        [self showSuccessHudWithHint:@"两次输入的密码不一致"];
        return;
    }
    
    
    NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
        [[AFHttpClient sharedAFHttpClient]repairPs:str token:str old:self.oldPsTx.text new:self.NewPsTx.text complete:^(ResponseModel * model) {
                
                [self showSuccessHudWithHint:model.retDesc];
                
                //退出登录
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
                [[AccountManager sharedAccountManager]logout];
                // 清除plist
                
                NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
                NSString * strrr = [userDefatluts objectForKey:@"changeid"];
                NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
                for(NSString* key in [dictionary allKeys]){
                    [userDefatluts removeObjectForKey:key];
                    [userDefatluts synchronize];
                }
                //引导页和chanlied不能被清除了
                [userDefatluts setObject:@"1" forKey:@"STARTFLAG"];
                [userDefatluts setObject:strrr forKey:@"changeid"];
                
            }];
        
    
   
    
    

}


@end
