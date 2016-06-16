//
//  FamilySpaceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FamilySpaceViewcontroller.h"
#import "LoginViewController.h"


@implementation FamilySpaceViewcontroller


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabFamily", nil)];
    self.view.backgroundColor = RED_COLOR;
//    UIButton * updateImageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    updateImageBtn.frame=CGRectMake(0, 0, 60, 18) ;
//    [updateImageBtn setTitle:NSLocalizedString(@"navUpdateimage", nil) forState:UIControlStateNormal];
//    updateImageBtn.titleLabel.font =[UIFont systemFontOfSize:13];
//    [updateImageBtn addTarget:self action:@selector(updateImage:) forControlEvents:UIControlEventTouchUpInside];
//    [updateImageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//
//    UIBarButtonItem * settings =[[UIBarButtonItem alloc]initWithCustomView:updateImageBtn];
//    self.navigationItem.rightBarButtonItem = settings;
    [self showBarButton:NAV_RIGHT title:@"添加照片" fontColor:[UIColor redColor]];
    
    
    
}


- (void)updateImage:(UIButton *)sender
{
    //测试
    LoginViewController * login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:NO];

    
}
-(void)doRightButtonTouch{
    //测试
    LoginViewController * login = [[LoginViewController alloc]init];
    [self presentViewController:login animated:NO completion:nil];

    

}




@end
