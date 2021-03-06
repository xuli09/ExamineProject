//
//  AppDelegate.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/2.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "AppDelegate.h"
#import "XLGKTabBarController.h"
#import "UMSocial.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//模拟内存警告需要调用的APP方法，还需要去相应的类里面去注册通知和调用didrecivememorywarning方法
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    NSLog(@"Appdelegate中调用DidReceiveMemoryWarning方法");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    //设置友盟Key
    [UMSocialData setAppKey:@"5640990267e58e77f8001408"];
    
    XLGKTabBarController * myTabBar = [[XLGKTabBarController alloc]init];
    self.window.rootViewController = myTabBar;
    
    //注册本地通知
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
//接收本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    UIAlertView * _alertView = [[UIAlertView alloc]initWithTitle:@"推送通知" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [_alertView show];
    
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
