//
//  InCallViewController.m
//  sebot
//
//  Created by yulei on 16/6/24.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "InCallViewController.h"

@interface InCallViewController ()

@end

@implementation InCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  //  [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    
    self.view.backgroundColor =[UIColor whiteColor];
  //  [self.ActView startAnimating];
    
   
    
    
}

- (IBAction)backBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  继承base
 */
- (void)setupData
{
    [super setupData];
    
}

- (void)setupView
{
    [super setupView];
     [self prefersStatusBarHidden];
    
    
    
}


// 重写
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)updateDeviceUseMember
{
    // 结束通话 更新设备使用记录
    // "object": "主叫对象(mobile 移动客户端/device 设备端)"
    [[AFHttpClient sharedAFHttpClient]POST:@"sebot/moblie/forward" parameters:@{@"userid" : @"1" , @"objective":@"device", @"token" : @"1",@"action":@"addCallRecords",@"data":@{@"calling":@"1",@"called":@"9000000006",@"object":@""}} result:^(id model) {
        
        NSLog(@"%@",model[@"retDesc"]);
        
    }];
    
}



@end
