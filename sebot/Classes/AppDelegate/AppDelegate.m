//
//  AppDelegate.m
//  sebot
//
//  Created by ldp on 16/6/1.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Launcher.h"
#import "AppDelegate+Sephone.h"
#import "AppDelegate+BaiduPush.h"
#import "IQKeyboardManager.h"
#import "AFHttpClient+MyDevice.h"
#import "MainTabViewController.h"
#import "MydeviceViewcontroller.h"
#import "VideomessageViewController.h"
static BOOL isBackGroundActivateApplication;
@interface AppDelegate ()<UIAlertViewDelegate>
{
    
    NSString * strAps;
    NSString * pushType;
    BOOL isIknow;
    MainTabViewController * mainVC;
    
    //45230482D344858E2A2DCFEB1B5DBA52DF4D82FE
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    mainVC =[[MainTabViewController alloc]init];
    
    //点击背景收起键盘
    [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:YES];
    //影藏键盘上的自定义工具栏
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    
    // 百度
    [self BaiduPush:application didFinishLaunchingWithOptions:launchOptions];
    // 基本
    [self launcherApplication:application didFinishLaunchingWithOptions:launchOptions];
    // sephone
    [self initSephoneVoip:application didFinishLaunchingWithOptions:launchOptions];
   
    
    
    return YES;
}



// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    
    strAps =userInfo[@"brid"];
    pushType =userInfo[@"type"];
    // 打印到日志 textView 中
    NSLog(@"********** iOS7.0之后 background **********");
    // 应用在前台，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"acitve ");
        
        if ([pushType isEqualToString:@"V001"]) {
        VideomessageViewController * video = [[VideomessageViewController alloc]init];
            UINavigationController * naVc = [[UINavigationController alloc]initWithRootViewController:video];
            [self.window.rootViewController presentViewController:naVc animated:NO completion:^{
                
            }];
            
            return;
            
        }

        
        if ([pushType isEqualToString:@"T002"] || [pushType isEqualToString:@"T004"]) {
            isIknow = YES;
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"desc"] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"bangdingshuaxin" object:nil];
            

        }else          {
            isIknow =  NO;
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"desc"] delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
        [alertView show];
            return;
            
        }
        
        
        
    }
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
        
        if ([pushType isEqualToString:@"V001"]) {
            VideomessageViewController * video = [[VideomessageViewController alloc]init];
            UINavigationController * naVc = [[UINavigationController alloc]initWithRootViewController:video];
            [self.window.rootViewController presentViewController:naVc animated:NO completion:^{
                
            }];            
            return;
            
        }

        
        /*
         MydeviceViewcontroller * devideVC =[[MydeviceViewcontroller alloc]init];
        [mainVC.selectedViewController presentViewController:devideVC animated:YES completion:nil];
         */
         if ([pushType isEqualToString:@"T001"]) {
             UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"desc"] delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
             [alertView show];
             
             return;
    
         }
        if ([pushType isEqualToString:@"T002"]) {
            
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"desc"] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;

        }
        
        if ([pushType isEqualToString:@"T003"]) {
            
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"desc"] delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
            [alertView show];
            return;
            
        }
        
           if ([pushType isEqualToString:@"T004"])
         {
             
             UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"desc"] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
             [alertView show];
             return;

             
         }
        
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        // 此处可以选择激活应用提前下载邮件图片等内容。
        isBackGroundActivateApplication = YES;
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
   
    
    
    NSLog(@"%@",userInfo);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
    
    // the user clicked OK
     NSString * str = [AccountManager sharedAccountManager].loginModel.userid;
    if (isIknow  ==  YES) {
        
    }else
    {
        
        if (buttonIndex == 0)
        {
            NSLog(@"拒绝");
            
             if ([pushType isEqualToString:@"T001"]) {
            [[AFHttpClient sharedAFHttpClient]responseBinding:str token:str brid:strAps operate:@"no" complete:^(ResponseModel * model) {
                
            }];
                 
             }else if ([pushType isEqualToString:@"T003"])
             {
                 
                   [[AFHttpClient sharedAFHttpClient]useresponseBinding: str token:str brid:strAps operate:@"no" complete:^(ResponseModel * model) {
                   }];
             }
            
            
        }else
        {
            
            if ([pushType isEqualToString:@"T001"]) {
                NSLog(@"同意");
                [[AFHttpClient sharedAFHttpClient]responseBinding:str token:str brid:strAps operate:@"yes" complete:^(ResponseModel * model) {

                }];
                
                
            }else if([pushType isEqualToString:@"T003"]){
                NSLog(@"同意");
                [[AFHttpClient sharedAFHttpClient]useresponseBinding: str token:str brid:strAps operate:@"yes" complete:^(ResponseModel * model) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"bangdingshuaxin" object:nil];
                }];
                
                
            }
            
            
        }

    }
    
    
    
}





// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
       // 网络错误
        if (error) {
            return ;
        }
        if (result) {
            // 确认绑定成功
            
            
            if ([result[@"error_code"]intValue]!=0) {
                return;
            }
            // 获取channel_id
            NSString *myChannel_id = [BPush getChannelId];
            [[NSUserDefaults standardUserDefaults] setObject:myChannel_id forKey:@"changeid"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            NSLog(@"==%@",myChannel_id);
            
            [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"result ============== %@",result);
                }
            }];
        }
    }];
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"desc"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
        //  [[NSNotificationCenter defaultCenter]postNotificationName:@"bangdingshuaxin" object:nil];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        
        NSLog(@"在杀死状态下");
        
    }

}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data8 if appropriate. See also applicationDidEnterBackground:.
}

@end
