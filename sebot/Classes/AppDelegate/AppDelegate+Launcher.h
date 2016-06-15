//
//  AppDelegate+Launcher.h
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"

@interface AppDelegate (Launcher)
- (void)launcherApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@property (nonatomic, strong) MainTabViewController* mainTabVC;
@property (nonatomic,strong)  LoginViewController * loginVC;


@end
