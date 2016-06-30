//
//  RepairPwViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RepairPwViewController.h"

@interface RepairPwViewController ()

@end

@implementation RepairPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavTitle: NSLocalizedString(@"RepairPw", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;

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
    
    
    if ([self.NewPsTx.text isEqualToString:self.ageinNewPsTx.text]) {
    
    // 修改密码
    [[AFHttpClient sharedAFHttpClient] POST:@"sebot/moblie/forward" parameters:@{@"userid" :  [AccountManager sharedAccountManager].loginModel.userid , @"objective":@"user", @"token" : @"1" , @"action" : @"modifyPassword", @"data" : @{@"userid" :  [AccountManager sharedAccountManager].loginModel.userid,@"oldpassword":self.oldPsTx.text,@"newpassword":self.NewPsTx.text}} result:^(id model) {
        [self showSuccessHudWithHint:model[@""]];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
        
    }else
    {
        
        [self showSuccessHudWithHint:@"密码不匹配"];
    }

}


@end
