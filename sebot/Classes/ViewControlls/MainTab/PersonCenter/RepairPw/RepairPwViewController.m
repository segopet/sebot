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
    
    
    
    if ([self.oldPsTx.text  isEqualToString:@""] || [self.NewPsTx.text isEqualToString:@"" ] || [self.ageinNewPsTx.text isEqualToString:@"" ]) {
        
        
        [self showSuccessHudWithHint:@"不能为空"];
        return;
    
    }else if ([self.oldPsTx.text isEqualToString: [AccountManager sharedAccountManager].loginModel.password] || [self.oldPsTx.text isEqualToString:self.NewPsTx.text])
    {
        
          [self showSuccessHudWithHint:@"新密码与旧密码一致"];
        
        return;
        
    }else if ([self.NewPsTx.text isEqualToString:self.ageinNewPsTx.text])
    {
        
            NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
            [[AFHttpClient sharedAFHttpClient]repairPs:str token:str old:self.oldPsTx.text new:self.NewPsTx.text complete:^(ResponseModel * model) {
                
                [self showSuccessHudWithHint:model.retDesc];
                LoginViewController * loginVC =[[LoginViewController alloc]init];
                [self presentViewController:loginVC animated:YES completion:nil];
                
            }];
        
    }
    else
    {
        
        [self showSuccessHudWithHint:@"原密码必须正确"];
        
    }
    
    

}


@end
