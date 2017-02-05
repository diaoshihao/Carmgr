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
#import "ViewController.h"
#import "PrivateModel.h"
#import "Interface.h"

@interface YWLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *userField;
@property (nonatomic, strong) UITextField   *passwdField;

@property (nonatomic, strong) UIButton      *loginBtn;

@property (nonatomic, strong) LoginView     *loginView;

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
    self.title = @"登录";
    self.backColor = [UIColor whiteColor];
    self.showShadow = YES;
    [self setShadowColor:[UIColor lightGrayColor]];
    [self createView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] != nil) {
        self.userField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        self.passwdField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
}

#pragma mark - 创建视图

- (void)createView {
    [self createTextField];
}

- (void)configLeftItemView {
    self.rightItemButton = [CustomButton buttonWithTitle:@"取消"];
    self.rightItemButton.normalColor = [DefineValue mainColor];
    self.rightItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.rightItemButton.titleLabel.font = [DefineValue font16];
    [self.rightItemButton addTarget:self action:@selector(CancelLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
}

- (void)configRightItemView {
    self.rightItemButton = [CustomButton buttonWithTitle:@"注册"];
    self.rightItemButton.normalColor = [DefineValue mainColor];
    self.rightItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightItemButton.titleLabel.font = [DefineValue font16];
    [self.rightItemButton addTarget:self action:@selector(pushToRegist) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
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
    self.loginBtn = [self.loginView createLoginButtonAtSuperView:self.view Constraints:self.passwdField target:self action:@selector(login)];
    
    //找回密码
    [self.loginView createButtonAtSuperView:self.view Constraints:self.loginBtn target:self action:@selector(resetPassword) forPasswd:YES];
    
    //手机快捷登录
    [self.loginView createButtonAtSuperView:self.view Constraints:self.loginBtn target:self action:@selector(loginByPhone) forPasswd:NO];
    
    //第三方登录
//    [self.loginView createThirdLoginAtSuperView:self.view target:self action:@selector(thirdLogin:)];
    
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark 跳转到注册
- (void)pushToRegist {
    YWRegistViewController *registVC = [[YWRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

#pragma mark 登录
- (void)login {
    [self.view endEditing:YES];
    
    [self clickDisable];
    
    if (self.userField.text.length == 0 || self.passwdField.text.length == 0) {
        [self showAlertViewTitle:@"提示" message:@"用户名和密码不能为空"];
        self.loginBtn.enabled = YES;
        return;
    }
    
    NSString *uuid = [Interface uuid];
    
    if (self.userField.text.length == 0 || self.passwdField.text.length == 0) {
        [self clickEnable];
        [self showAlertViewTitle:@"提示" message:@"用户名和密码不能为空"];
        return;
    }
    
    NSArray *login = [Interface applogin:self.userField.text password:self.passwdField.text type:@"0" verf_code:@"" uuid:uuid];
    [MyNetworker POST:login[InterfaceUrl] parameters:login[Parameters] success:^(id responseObject) {
        [self clickEnable];
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            //登录成功保存数据
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];//登录状态
            
            [[NSUserDefaults standardUserDefaults] setObject:self.userField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwdField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];//token
            
            //自动登录打开
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AutoLogin"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self showAlertViewTitle:nil message:@"登录成功"];
        } else {
            [self showAlertViewTitle:@"提示" message:@"用户名或密码错误"];
        }
    } failure:^(NSError *error) {
        [self clickEnable];
        [self showAlertViewTitle:@"提示" message:@"网络错误"];
    }];
}

#pragma mark 个人资料
- (void)getPrivate {
    
}

- (void)thirdLogin:(UIButton *)sender {
    if (sender.tag == 100) {
        NSLog(@"QQ登录");
    } else {
        NSLog(@"微信登录");
    }
}

- (void)showAlertViewTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVC animated:YES completion:^{
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFireMethod:) userInfo:alertVC repeats:NO];        
    }];
    
}

#pragma mark 定时器
- (void)timerFireMethod:(NSTimer *)timer {
    UIAlertController *alertVC = [timer userInfo];
    [alertVC dismissViewControllerAnimated:YES completion:^{
        if (alertVC.title == nil) {//login success
            
            //使用present方式到登录页面的
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.loginOption == LoginOptionRelogin || self.loginOption == LoginOptionAuto) {
                }
            }];
            
            [(ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController showHomePage];
        }
    }];
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
