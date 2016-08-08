//
//  AppDelegate+Sephone.m
//  sebot
//
//  Created by yulei on 16/6/15.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AppDelegate+Sephone.h"

@implementation AppDelegate (Sephone)

- (void)initSephoneVoip:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Sephone  单向无须做太多操作(考虑到以后)
      [[SephoneManager instance]	startSephoneCore];

}
@end
