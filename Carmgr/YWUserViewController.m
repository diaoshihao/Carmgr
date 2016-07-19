//
//  YWUserViewController.m
//  Carmgr
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWUserViewController.h"
#import "YWPublic.h"
#import "UserCenterFunc.h"
#import "YWLoginViewController.h"
#import "CarVerifyViewController.h"
#import "SettingViewController.h"

@interface YWUserViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UserCenterFunc    *createView;

@property (nonatomic, strong) NSArray           *dataArray;

@end

@implementation YWUserViewController

#pragma mark 跳转到登录界面
- (void)pushToLoginVC {
    
    //如果没有登录
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        UIViewController *loginVC = [[YWLoginViewController alloc] init];
        UINavigationController *navigaVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navigaVC animated:YES completion:nil];
    } else {
        
    }
    
}

- (void)pushToAddCarInfo {
    CarVerifyViewController *CarVerifyVC = [[CarVerifyViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:CarVerifyVC];
    [self presentViewController:navigationVC animated:YES completion:nil];
}

- (void)pushToSettingPage {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //实现滑动返回
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    self.createView = [[UserCenterFunc alloc] init];
    self.createView.actionTarget = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.createView createTableView:self.view];
        
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
    //滑动返回
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //登录成功改变用户名
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self.createView.userName setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] forState:UIControlStateNormal];
    }
    
}

#pragma mark - 右滑返回上一页
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    //滑动返回
    [super viewDidDisappear:YES];
    self.navigationController.delegate = nil;
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
