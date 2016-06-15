//
//  MainTabViewController.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MainTabViewController.h"
#import "AppDelegate.h"
#import "MydeviceViewcontroller.h"
#import "PersonCenterViewcontroller.h"
#import "FamilySpaceViewcontroller.h"

@interface MainTabViewController()
{
    
    AppDelegate * app;
    
}

@property (nonatomic, strong) UINavigationController* navFamilyVC;
//家庭圈
@property (nonatomic, strong) UINavigationController* navMyDeviceVC;
//我的设备
@property (strong, nonatomic) UINavigationController  *navPersonCenterVC;
//个人中心
@end

@implementation MainTabViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    app= (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)setupSubviews
{
    
    self.tabBar.backgroundColor=[UIColor whiteColor];
    
    self.viewControllers = @[
                             self.navSquareVC,
                             self.navNearVC,
                             self.navEggVC
                             ];
    
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
    self.tabBar.layer.shadowOpacity = 0.4;
    self.tabBar.layer.shadowRadius = 2;
    
}

//家庭圈
- (UINavigationController *)navSquareVC{
    if (!_navFamilyVC) {
        
        FamilySpaceViewcontroller* vc = [[FamilySpaceViewcontroller alloc] init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:nil
                                      image:[[UIImage imageNamed:@"家庭圈1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"家庭圈.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navFamilyVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navFamilyVC;
}

//我的设备
- (UINavigationController *)navNearVC{
    if (!_navMyDeviceVC) {
        
        MydeviceViewcontroller* vc = [[MydeviceViewcontroller alloc] init];
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:nil
                                      image:[[UIImage imageNamed:@"我的设备1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"我的设备.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navMyDeviceVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navMyDeviceVC;
}

//个人中心
- (UINavigationController *)navEggVC{
    if (!_navPersonCenterVC) {
        
        PersonCenterViewcontroller* vc = [[PersonCenterViewcontroller alloc] init];
        
        vc.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:nil
                                      image:[[UIImage imageNamed:@"个人中心1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              selectedImage:[[UIImage imageNamed:@"个人中心.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        _navPersonCenterVC = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    return _navPersonCenterVC;
}


- (void)pushViewController:(UIViewController*)viewController {
    
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        [((UINavigationController*)self.selectedViewController) pushViewController:viewController animated:YES];
        
    }
    
}

@end
