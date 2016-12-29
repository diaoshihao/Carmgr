//
//  ViewController.m
//  Carmgr
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ViewController.h"
#import "Interface.h"
#import "YWTabBarController.h"
#import "YWLoginViewController.h"
#import "GeneralControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self showPage];
    
}

//显示页面
- (void)showPage {
    BOOL autoLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"AutoLogin"];
    if (autoLogin) {
        //自动登录
        [self autoLogin];
    } else {
        [self loginDefaultCount];
    }
}

//显示首页
- (void)showHomePage {
    [self removeAllChildViewControllers];
    [self removeAllSubviews];
    
    YWTabBarController *homePage = [[YWTabBarController alloc] init];
    [self addChildViewController:homePage];
    [self.view addSubview:homePage.view];
}

//显示登录页面
- (void)showLoginPage {
    [self removeAllChildViewControllers];
    [self removeAllSubviews];
    
    YWLoginViewController *loginVC = [[YWLoginViewController alloc] init];
    UINavigationController *loginNVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self addChildViewController:loginNVC];
    [self.view addSubview:loginNVC.view];
}

//移除所有子视图
- (void)removeAllSubviews {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

//移除所有子控制器
- (void)removeAllChildViewControllers {
    for (UIViewController *childVC in self.childViewControllers) {
        [childVC removeFromParentViewController];
    }
}

//自动登录
- (void)autoLogin {
    NSString *username = [Interface username];
    NSString *password = [Interface password];
    NSString *uuid = [Interface uuid];
    
    if (username == nil || password == nil) {
        [self loginDefaultCount];
        return;
    }
    
    NSArray *login = [Interface applogin:username password:password type:@"0" verf_code:@"" uuid:uuid];
    [MyNetworker POST:login[InterfaceUrl] parameters:login[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            //登录成功保存数据
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];//登录状态
            //自动登录打开
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AutoLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
    
            [self showHomePage];
        } else {
            [self alertDismissAfter:2.5 message:@"登录失败，请检查网络"];
            [self showLoginPage];
        }
    } failure:^(NSError *error) {
        [self alertDismissAfter:2.5 message:@"登录失败，请检查网络"];
        [self showLoginPage];
    }];
}

//登录默认账号以显示展示性页面（因为后台接口中需要用户名及token）
- (void)loginDefaultCount {
    NSString *username = [Interface defaultUsername];
    NSString *password = [Interface defaultPassword];
    NSString *uuid = [Interface uuid];
    
    NSArray *login = [Interface applogin:username password:password type:@"0" verf_code:@"" uuid:uuid];
    [MyNetworker POST:login[InterfaceUrl] parameters:login[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            //默认账户，状态和未登录一致
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];//登录状态
            //自动登录关闭
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AutoLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"defaultToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self showHomePage];
        } else {
            [self showMessage:@"连接失败，请检查网络后重新启动"];
        }
    } failure:^(NSError *error) {
        [self showMessage:@"连接失败，请检查网络后重新启动"];
    }];
}

- (void)showMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self exitApplication];
    }];
    [alertVC addAction:sure];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)exitApplication {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:0.618f animations:^{
        window.alpha = 0;
        window.bounds = CGRectMake(([UIScreen mainScreen].bounds.size.height - window.bounds.size.height) / 2, ([UIScreen mainScreen].bounds.size.width - window.bounds.size.width) / 2, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
