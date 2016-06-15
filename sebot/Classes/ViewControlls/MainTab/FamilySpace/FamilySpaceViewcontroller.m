//
//  FamilySpaceViewcontroller.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FamilySpaceViewcontroller.h"

@implementation FamilySpaceViewcontroller


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavTitle: NSLocalizedString(@"tabFamily", nil)];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    UIButton * updateImageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    updateImageBtn.frame=CGRectMake(0, 0, 60, 18) ;
    [updateImageBtn setTitle:NSLocalizedString(@"navUpdateimage", nil) forState:UIControlStateNormal];
    updateImageBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    [updateImageBtn addTarget:self action:@selector(updateImage:) forControlEvents:UIControlEventTouchUpInside];
    [updateImageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * settings =[[UIBarButtonItem alloc]initWithCustomView:updateImageBtn];
    self.navigationItem.rightBarButtonItem = settings;
    
}


- (void)updateImage:(UIButton *)sender
{
    
    
}
@end
