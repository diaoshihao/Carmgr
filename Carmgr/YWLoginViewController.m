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
#import "YWTabBarController.h"
#import "PrivateModel.h"

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
    
    [self createView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"] != nil) {
        self.userField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
        self.passwdField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    //v1.0不设置取消按钮
    
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
    
    self.loginBtn.enabled = NO;//防止用户多次点击
    
    if (self.userField.text.length == 0 || self.passwdField.text.length == 0) {
        [self showAlertViewTitle:@"提示" message:@"用户名和密码不能为空"];
    } else {
        
        //username=%@&password=%@&type=%@&verf_code=%@&uuid=%@&version=1.0
        NSString *urlStr = [NSString stringWithFormat:kLOGIN,self.userField.text,self.passwdField.text,0,nil,nil];
        //密码加密
        /*[YWPublic encryptMD5String:self.passwdField.text]*/

        [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
                
                //登录成功保存数据
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];//登录状态
                
                [[NSUserDefaults standardUserDefaults] setObject:dataDict[@"token"] forKey:@"token"];//token
                
                [self showAlertViewTitle:nil message:@"登录成功"];
            } else {
                [self showAlertViewTitle:@"提示" message:@"用户名或密码错误"];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertViewTitle:@"提示" message:@"网络错误"];
        }];
    }
}

#pragma mark 个人资料
- (void)getPrivate {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *urlStr = [NSString stringWithFormat:kPRIVATE,self.userField.text,token];
    
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            
            PrivateModel *privateModel = [[PrivateModel alloc] initWithDict:dataDict];
            [[NSUserDefaults standardUserDefaults] setObject:privateModel.username forKey:@"username"];
            
            //插入数据库前删除数据
            [[YWDataBase sharedDataBase] deleteDatabaseFromTable:@"tb_private"];
            
            //插入数据库
            [[YWDataBase sharedDataBase] insertPrivateWithModel:privateModel];
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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
    [alertVC dismissViewControllerAnimated:YES completion:nil];
    if (alertVC.title == nil) {//登录成功
        if (self.isFromHome) { //token失效,登录后返回首页并自动刷新
            self.isFromHome = NO;//重置状态
            [self dismissViewControllerAnimated:YES completion:^{
                [self getPrivate];
                [self.fromVC refresh];
            }];
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"] == YES) {
                    YWTabBarController *tabBarVC = [[YWTabBarController alloc] init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
                }
                [self getPrivate];
            }];
        }
    }
    self.loginBtn.enabled = YES;
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
