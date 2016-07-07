//
//  RepairPwViewController.m
//  sebot
//
//  Created by yulei on 16/6/17.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RepairPwViewController.h"
#import "AFHttpClient+ReparPassword.h"

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
    
    NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
   [[AFHttpClient sharedAFHttpClient]repairPs:str token:str old:self.oldPsTx.text new:self.NewPsTx.text complete:^(ResponseModel * model) {
       
       [self.navigationController popViewControllerAnimated:YES];
   }];
        
        
    }else
    {
        
        [self showSuccessHudWithHint:@"密码不匹配"];
    }

}


@end
