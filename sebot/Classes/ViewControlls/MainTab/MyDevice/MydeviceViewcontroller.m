//
//  MydeviceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MydeviceViewcontroller.h"

@implementation MydeviceViewcontroller


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabDevice", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    
    
    UIButton * updateImageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    updateImageBtn.frame=CGRectMake(0, 0, 60, 18) ;
    [updateImageBtn setTitle:NSLocalizedString(@"navAddDev", nil) forState:UIControlStateNormal];
    updateImageBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    [updateImageBtn addTarget:self action:@selector(addDev:) forControlEvents:UIControlEventTouchUpInside];
    [updateImageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * settings =[[UIBarButtonItem alloc]initWithCustomView:updateImageBtn];
    self.navigationItem.rightBarButtonItem = settings;
    
}

// 弹出提示
- (void)addDev:(UIButton *)sender
{
    
    
    
}



@end
