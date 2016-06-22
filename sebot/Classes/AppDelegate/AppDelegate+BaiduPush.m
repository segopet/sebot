//
//  AppDelegate+BaiduPush.m
//  sebot
//
//  Created by yulei on 16/6/22.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AppDelegate+BaiduPush.h"

@implementation AppDelegate (BaiduPush)

- (void)BaiduPush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
   
    [BPush registerChannel:launchOptions apiKey:@"apiONPZtk3ewMGLC3S3UIxqGtZF7cWja" pushMode:BPushModeDevelopment withFirstAction:@"打开" withSecondAction:@"回复" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    
    
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 绑定返回值
        if (result[@"response_params"][@"channel_id"]) {
            
        }
    }];

    
}
@end
