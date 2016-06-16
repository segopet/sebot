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
    self.view.backgroundColor = [UIColor whiteColor];
    [self showBarButton:NAV_RIGHT title:NSLocalizedString(@"navUpdateimage", nil) fontColor:[UIColor redColor]];
    
    
    
}



-(void)doRightButtonTouch{
    //测试
    LoginViewController * login = [[LoginViewController alloc]init];
    [self presentViewController:login animated:NO completion:nil];

    

}




@end
