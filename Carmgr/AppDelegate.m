//
//  AppDelegate.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AppDelegate.h"
#import "YWTabBarController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

@property (nonatomic) BOOL finishLogin;

@end

@implementation AppDelegate
{
    UITextView *textView;
}

- (void)developAccountLogin {
    self.finishLogin = NO;
    NSString *username = nil;
    NSString *password = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"15014150833" forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:@"12345678" forKey:@"password"];
        username = @"15014150833";
        password = @"12345678";
    } else {
        username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:kLOGIN,username,password,0,nil,nil];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //登录成功保存数据
        [[NSUserDefaults standardUserDefaults] setObject:dataDict[@"token"] forKey:@"token"];//token
        
        self.finishLogin = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)firstLaunchOrNot {
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([version isEqualToString:saveVersion]) { // 不是第一次使用这个版本
        //是否第一次使用
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstLaunch"];
        self.window.rootViewController = [[YWTabBarController alloc] init];
        //进入程序,自动登录！！！！！
        
    } else { // 版本号不一样：第一次使用新版本
        // 将新版本号写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //移动网络下载图片打开
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MONET"];
        
        //是否第一次使用
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        
        // 显示版本新特性界面
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
        
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    textView = [[UITextView alloc] init];//先实例化一个textView，防止子视图有textview的界面初次进入时发生卡顿的现象
    
    [self developAccountLogin];
    
    while (!self.finishLogin)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
    
    [self firstLaunchOrNot];
    
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
    
    //添加退出登录方法
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
}

@end
