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

#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@interface YWUserViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UserCenterFunc    *createView;

@property (nonatomic, strong) UIView            *backView;

@property (nonatomic, strong) UIImageView       *userImageView;

@property (nonatomic, strong) UIButton          *userName;
@property (nonatomic, strong) UIButton          *messageButton;

@property (nonatomic, assign) BOOL              isLogin;

@property (nonatomic, strong) NSArray           *dataArray;

@end

@implementation YWUserViewController
{
    CGFloat width;      //屏幕宽
    CGFloat height;     //背景高
    CGFloat imageHeight;//头像长
}

#pragma mark - 右滑返回上一页
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
}

#pragma mark 跳转到登录界面
- (void)pushToLoginVC {
    UIViewController *loginVC = [[YWLoginViewController alloc] init];
    UINavigationController *navigaVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigaVC animated:YES completion:nil];
}

#pragma mark - 创建视图
- (void)createAllViews {
    self.createView = [[UserCenterFunc alloc] init];
    
    //背景
    self.backView = [self.createView createBackgroundViewAtView:self.view height:height];
    
    //头像
    self.userImageView = [self.createView createUserImageView:CGSizeMake(imageHeight, imageHeight) left:imageHeight/4 bottom:-imageHeight/4];
    
    //用户名
    self.userName = [self.createView createUserNameButton:self title:@"登录/注册" imageView:nil left:imageHeight/4];
    
    //信息
    self.messageButton = [self.createView createMessageImage:self image:@"信封" size:CGSizeMake(40, 40) top:imageHeight/4 right:-imageHeight/6];
    
    //设置
    [self.createView createSettingImage:self image:@"设置" size:CGSizeMake(40, 40) right:-imageHeight/6];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //宽高大小定义
    width = self.view.bounds.size.width;
    height = width / 2.5;
    imageHeight = height / 2;
    
    //实现滑动返回
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [self createAllViews];
        
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)viewDidDisappear:(BOOL)animated {
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
