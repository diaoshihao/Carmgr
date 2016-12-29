//
//  AppDelegate.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GuideViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UITextView *textView;
}

//高德地图配置key
- (void)configForAMap {
    [AMapServices sharedServices].apiKey = @"e69025b7664fa7cb60f866e6f0117be7";
}

- (BOOL)firstLaunchOrNot {
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([version isEqualToString:saveVersion]) { // 不是第一次使用这个版本
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstLaunch"];
        
    } else { // 版本号不一样：第一次使用新版本
        // 将新版本号写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        
        //移动网络下载图片打开
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MONET"];
        
        //是否第一次使用
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        
        //自动登录关闭
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AutoLogin"];
        
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    textView = [[UITextView alloc] init];//先实例化一个textView，防止子视图有textview的界面初次进入时发生卡顿的现象
    
    //高德地图配置
    [self configForAMap];
    
    //如果是第一次启动App
    if ([self firstLaunchOrNot]) {
        // 显示版本新特性界面
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    } else {
        self.window.rootViewController = [[ViewController alloc] init];
    }
    
    return YES;
    
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
