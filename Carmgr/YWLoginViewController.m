//
//  YWLoginViewController.m
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWLoginViewController.h"
#import <Masonry.h>
#import "YWPublic.h"
#import "YWRegistViewController.h"
#import "LoginView.h"
#import "FindPasswdViewController.h"
#import "FastLoginViewController.h"

@interface YWLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userField;
@property (nonatomic, strong) UITextField *passwdField;

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation YWLoginViewController

//懒加载
- (LoginView *)loginView {
    if (_loginView == nil) {
        _loginView = [[LoginView alloc] init];
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self createView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.userField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    self.passwdField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

#pragma mark - 创建视图

- (void)createView {
    [self createBarView];
    [self createTextField];
}

#pragma mark 导航栏
- (void)createBarView {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    
    self.navigationItem.leftBarButtonItem = [self.loginView createBarButtonItem:CGRectMake(0, 0, 60, 40) title:@"取消" target:self action:@selector(CancelLogin)];
    
    self.navigationItem.rightBarButtonItem = [self.loginView createBarButtonItem:CGRectMake(0, 0, 60, 40) title:@"注册" target:self action:@selector(pushToRegist)];
    
}

#pragma mark 主要视图
- (void)createTextField {
    //用户名
    self.userField = [self.loginView createTextFieldAtSuperView:self.view Constraints:nil isUserField:YES];
    self.userField.delegate = self;
    
    //密码
    self.passwdField = [self.loginView createTextFieldAtSuperView:self.view Constraints:self.userField isUserField:NO];
    self.passwdField.delegate = self;
    
    //登录
    UIButton *loginBtn = [self.loginView createLoginButtonAtSuperView:self.view Constraints:self.passwdField target:self action:@selector(login)];
    
    //找回密码
    [self.loginView createButtonAtSuperView:self.view Constraints:loginBtn target:self action:@selector(resetPassword) forPasswd:YES];
    
    //手机快捷登录
    [self.loginView createButtonAtSuperView:self.view Constraints:loginBtn target:self action:@selector(loginByPhone) forPasswd:NO];
    
    //第三方登录
    [self.loginView createThirdLoginAtSuperView:self.view target:self action:@selector(thirdLogin:)];
    
}

#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userField) {
        [self.passwdField becomeFirstResponder];
    }else if (self.userField.text.length == 0) {
        [self.userField becomeFirstResponder];
    }else {
        [self login];
    }
    return YES;
}

#pragma mark - 响应事件
#pragma mark 取消登录
- (void)CancelLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 跳转到注册
- (void)pushToRegist {
    YWRegistViewController *registVC = [[YWRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

#pragma mark 登录
- (void)login {
    [self.view endEditing:YES];
    //密码加密
    NSString *loginURL = [NSString stringWithFormat:kLOGIN,self.userField.text,self.passwdField.text];
    /*[YWPublic encryptMD5String:self.passwdField.text]*/

    [YWPublic afPOST:loginURL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"网络请求成功：%@",dataDict);
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            
            //登录成功保存数据
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];//登录状态
            [[NSUserDefaults standardUserDefaults] setObject:self.userField.text forKey:@"username"];//用户名
            [[NSUserDefaults standardUserDefaults] setObject:self.passwdField.text forKey:@"password"];//密码
            [[NSUserDefaults standardUserDefaults] setObject:dataDict[@"token"] forKey:@"token"];//token
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertVC animated:YES completion:^{
                [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timerFireMethod:) userInfo:alertVC repeats:NO];
            }];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败%@",error);
    }];
}

- (void)thirdLogin:(UIButton *)sender {
    if (sender.tag == 100) {
        NSLog(@"QQ登录");
    } else {
        NSLog(@"微信登录");
    }
}

#pragma mark 定时器
- (void)timerFireMethod:(NSTimer *)timer {
    UIAlertController *alertVC = [timer userInfo];
    [alertVC dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 找回密码
- (void)resetPassword {
    FindPasswdViewController *findPasswdVC = [[FindPasswdViewController alloc] init];
    [self.navigationController pushViewController:findPasswdVC animated:YES];
}

#pragma mark 手机快捷登录
- (void)loginByPhone {
    FastLoginViewController *fastLoginVC = [[FastLoginViewController alloc] init];
    [self.navigationController pushViewController:fastLoginVC animated:YES];
}

#pragma mark 收缩键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
