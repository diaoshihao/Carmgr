//
//  YWRegistViewController.m
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWRegistViewController.h"
#import "RegistView.h"
#import "YWPublic.h"
#import "ServiceDelegateController.h"
#import "ViewController.h"
#import <Masonry.h>
#import "UIViewController+ShowView.h"

@interface YWRegistViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneNum;
@property (nonatomic, strong) UITextField *verifyCode;
@property (nonatomic, strong) UITextField *passwdField;
@property (nonatomic, strong) UITextField *repeatPasswd;

@property (nonatomic, strong) RegistView  *registView;

@property (nonatomic, strong) NSString *mobile;

@end

@implementation YWRegistViewController
{
    NSString *uuid;
    UIButton *getVerifyCode;
    NSInteger timeout;
    NSTimer *downTimer;
}

- (RegistView *)registView {
    if (_registView == nil) {
        _registView = [[RegistView alloc] init];
    }
    return _registView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"注册";
    self.showShadow = YES;
    [self setShadowColor:[UIColor lightGrayColor]];
        
    [self createInputPhoneNumView];
    
}

//进入下一步前移除所有子视图
- (void)removeAllSubviews {
    for (UIView *subview in self.view.subviews) {
        [subview removeFromSuperview];
    }
}

#pragma mark - 输入手机号
- (void)createInputPhoneNumView {
    UIView *view = [self.registView createSelectViewAtSuperView:self.view registStep:RegistStepInputPhoneNum];
    self.phoneNum = [self.registView createTextFieldAtSuperView:self.view broView:view placeholder:@"请输入您的手机号"];
    self.phoneNum.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNum.returnKeyType = UIReturnKeyNext;
    UIButton *button = [self.registView createButtonAtSuperView:self.view Constraints:self.phoneNum title:@"获取验证码" target:self action:@selector(getVerifyCode)];
    
    //同意平台协定
    [self.registView createAgreementViewAtSuperView:self.view broview:button target:self action:@selector(serviceDelegate)];
    
}

//跳转到用户协议界面
- (void)serviceDelegate {
    ServiceDelegateController *serviceDelegateVC = [[ServiceDelegateController alloc] init];
    [self.navigationController pushViewController:serviceDelegateVC animated:YES];
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
        if (alertVC.title == nil) {
            [(ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController showHomePage];
        }
    }];
}


#pragma mark 获取验证码
- (void)getVerifyCode {
    BOOL correct = [RegularTools validateMobile:self.phoneNum.text];
    if (correct) {
        uuid = [Interface uuid];
        
        //网络请求获取验证码   参数：username=%@&type=%@&uuid=%@&version=1.0
        //type == 0：注册；1：登录；2:找回密码
        NSArray *getverify = [Interface appsendverfcode:self.phoneNum.text type:@"0" uuid:uuid];
        [MyNetworker POST:getverify[InterfaceUrl] parameters:getverify[Parameters] success:^(id responseObject) {
            if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
                
                self.mobile = self.phoneNum.text;
                [self removeAllSubviews];
                [self createInputVerifyCodeView];
                if (getVerifyCode != nil) {
                    [self startTimer];
                }
            } else if ([responseObject[@"opt_info"] isEqualToString:@"user account is already exist"]) {
                [self showAlertViewTitle:@"提示" message:@"用户已存在，请返回登录"];
            }

        } failure:^(NSError *error) {
            [self showAlertViewTitle:@"提示" message:@"网络错误"];
        }];
        
    } else {
        [self showAlertViewTitle:@"提示" message:@"请输入正确的手机号"];
    }
}

//重新获取验证码
- (void)regetVerifyCode {
    [self getVerifyCode];
}

#pragma mark - 输入验证码
- (void)createInputVerifyCodeView {
    UIView *view = [self.registView createSelectViewAtSuperView:self.view registStep:RegistStepInputVerifyCode];
    
    UILabel *label = [self.registView createInfoLabelAtSuperView:self.view phoneNum:self.phoneNum.text broview:view];
    self.verifyCode = [self.registView createTextFieldAtSuperView:self.view broView:label placeholder:@"请输入短信中的验证码"];
    self.verifyCode.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyCode.returnKeyType = UIReturnKeyNext;
    [self.registView createButtonAtSuperView:self.view Constraints:self.verifyCode title:@"提交验证码" target:self action:@selector(commitVerifyCode)];
    
    //重新获取验证码
    getVerifyCode = [YWPublic createButtonWithFrame:CGRectZero title:@"  重新获取验证码  " imageName:nil];
    getVerifyCode.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //设置颜色
    [getVerifyCode setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
    getVerifyCode.layer.borderWidth = 1.0;
    getVerifyCode.layer.cornerRadius = 6;
    getVerifyCode.clipsToBounds = YES;
    
    [getVerifyCode addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerifyCode];
    
    [getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.verifyCode);
    }];
}

- (void)startTimer {
    timeout = 60;
    getVerifyCode.enabled = NO;
    downTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonState) userInfo:nil repeats:YES];
}

- (void)changeButtonState {
    timeout--;
    [getVerifyCode setTitle:[NSString stringWithFormat:@"  %ld秒后可重新发送  ",(long)timeout] forState:UIControlStateDisabled];
    [getVerifyCode setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    getVerifyCode.layer.borderColor = [UIColor grayColor].CGColor;
    if (timeout == 0) {
        getVerifyCode.enabled = YES;
        [getVerifyCode setTitle:@"  重新获取验证码  " forState:UIControlStateNormal];
        getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
        [downTimer invalidate];
    }
}

#pragma mark 校验验证码
- (void)commitVerifyCode {
    
    if (self.verifyCode.text.length != 4) {
        [self showAlertViewTitle:@"提示" message:@"请输入正确的4位验证码"];
        return;
    }
    //username=%@&mobile=%@&verf_code=%@&type=%d&uuid=%@&version=1.0
    //type == 0：注册；1：登录；2:找回密码
    NSArray *checkcode = [Interface appcheckverfcode:self.phoneNum.text mobile:self.phoneNum.text verf_code:self.verifyCode.text type:@"0" uuid:uuid];
    [MyNetworker POST:checkcode[InterfaceUrl] parameters:checkcode[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            self.mobile = self.phoneNum.text;
            [self removeAllSubviews];
            [self createSetSecureView];
            
        } else {
            [self showAlertViewTitle:@"提示" message:@"验证码错误，请重新输入"];
        }
    } failure:^(NSError *error) {
        [self showAlertViewTitle:@"提示" message:@"网络错误"];
    }];
    
}

#pragma mark 设置密码
- (void)createSetSecureView {    
    UIView *view = [self.registView createSelectViewAtSuperView:self.view registStep:RegistStepSetSecure];
    self.passwdField = [self.registView createTextFieldAtSuperView:self.view broView:view placeholder:@"请输入密码（长度在6-32个字符之间）"];
    self.repeatPasswd = [self.registView createTextFieldAtSuperView:self.view broView:self.passwdField placeholder:@"请再次输入密码"];
    [self.registView createButtonAtSuperView:self.view Constraints:self.repeatPasswd title:@"注册" target:self action:@selector(regist)];
    
    self.passwdField.returnKeyType = UIReturnKeyNext;
    self.passwdField.delegate = self;
    self.repeatPasswd.returnKeyType = UIReturnKeyDone;
    self.repeatPasswd.delegate = self;
}

#pragma mark 注册
- (void)regist {
    
    if (![self.passwdField.text isEqualToString:self.repeatPasswd.text]) {
        [self showAlertViewTitle:@"提示" message:@"请输入相同的密码"];
    } else if (self.passwdField.text.length > 32 || self.passwdField.text.length < 6) {
        [self showAlertViewTitle:@"提示" message:@"密码位数不正确"];
    } else {
        //注册
        NSArray *regist = [Interface appregister:self.phoneNum.text password:self.passwdField.text mobile:self.phoneNum.text];
        [MyNetworker POST:regist[InterfaceUrl] parameters:regist[Parameters] success:^(id responseObject) {
            if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:self.mobile forKey:@"mobile"];
                [[NSUserDefaults standardUserDefaults] setObject:self.mobile forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] setObject:self.passwdField.text forKey:@"password"];
                //登录成功保存数据
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];//登录状态
                //自动登录打开
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AutoLogin"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self showAlertViewTitle:nil message:@"注册成功"];
                
            } else {
                [self showAlertViewTitle:@"提示" message:@"注册失败"];
            }
        } failure:^(NSError *error) {
            [self showAlertViewTitle:@"提示" message:@"网络错误"];
        }];
        
        NSString *urlStr = [NSString stringWithFormat:kREGISTER,self.mobile,self.passwdField.text,self.mobile,0];
        [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:self.mobile forKey:@"mobile"];
                [[NSUserDefaults standardUserDefaults] setObject:self.mobile forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] setObject:self.passwdField.text forKey:@"password"];
                //登录成功保存数据
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];//登录状态
                //自动登录打开
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AutoLogin"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self showAlertViewTitle:nil message:@"注册成功"];
                
            } else {
                [self showAlertViewTitle:@"提示" message:@"注册失败"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertViewTitle:@"提示" message:@"网络错误"];
        }];
    }
}

#pragma mark 键盘活动
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwdField) {
        [self.repeatPasswd becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return YES;
}

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
