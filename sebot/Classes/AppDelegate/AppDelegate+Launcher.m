//
//  AppDelegate+Launcher.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AppDelegate+Launcher.h"
#import "PopStartView.h"

@interface AppDelegate()<GetScrollVDelegate>


@end

@implementation AppDelegate (Launcher)

- (void)launcherApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       GREEN_COLOR,NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotificationLoginStateChange object:nil];
    
    
    
     //[self checkLogin];
    [self enterMainTabVC];

    [[AFHttpClient sharedAFHttpClient] test];
}

// 检查登录
- (void)checkLogin{
    
}

// 登录状态

-(void)loginStateChange:(NSNotification *)notification{
    
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {
        [self enterMainTabVC];
    }else{
        
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        if (![[userdefaults objectForKey:@"STARTFLAG"] isEqualToString:@"1"]) {//第一次启动软件
            [self.window makeKeyAndVisible];
            [userdefaults setObject:@"1" forKey:@"STARTFLAG"];
            [userdefaults synchronize];
            PopStartView *popStartV = [[PopStartView alloc]initWithFrame:self.window.bounds];
            popStartV.delegate = self;
            popStartV.ParentView = self.window;
            [self.window addSubview:popStartV];
            
        }else {//不是第一次启动软件
            [self enterLoginVC];
            
        }
        
        
        
    }
}


//代理函数
- (void)getScrollV:(NSString *)popScroll
{
    
    [self enterLoginVC];
    
    
}




/**
 *  进入主界面
 */
- (void)enterMainTabVC{
    
//    if (self.loginVC) {
//        self.loginVC = nil;
//    }
    
    self.mainTabVC = [[MainTabViewController alloc]init];
    
    self.window.rootViewController = self.mainTabVC;
    
    [self.window makeKeyAndVisible];
}

/**
 *  进入登陆界面
 */
- (void)enterLoginVC{
    
    if (self.mainTabVC) {
        self.mainTabVC = nil;
    }
    
    self.loginVC = [[LoginViewController alloc]init];
    
    UINavigationController * loginNaVc = [[UINavigationController alloc]initWithRootViewController:self.loginVC];
    self.window.rootViewController = loginNaVc;
    
    [self.window makeKeyAndVisible];
}

@end
