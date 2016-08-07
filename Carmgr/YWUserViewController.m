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
#import "UserInfoViewController.h"
#import "PrivateModel.h"
#import <UIImageView+WebCache.h>

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
        [self pushToUserInfo];
    }
    
}

- (void)pushToAddCarInfo {
    CarVerifyViewController *CarVerifyVC = [[CarVerifyViewController alloc] init];
    CarVerifyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CarVerifyVC animated:YES];
}

- (void)pushToSettingPage {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)pushToUserInfo {
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.headImage = self.createView.userImageView.image;
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
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
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"] == YES) {
//        [self.createView.userName setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] forState:UIControlStateNormal];
//        [self.createView.userImageView sd_setImageWithURL:[NSURL URLWithString:privateModel.avatar] placeholderImage:[UIImage imageNamed:@"头像大"]];
//    } else {
//        [self.createView.userName setTitle:@"登录/注册" forState:UIControlStateNormal];
//        self.createView.userImageView.image = [UIImage imageNamed:@"头像大"];
//    }
    
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
