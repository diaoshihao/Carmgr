//
//  FastLoginViewController.m
//  Carmgr
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "FastLoginViewController.h"
#import <Masonry.h>
#import "YWPublic.h"
#import "YWTabBarController.h"
#import "ServiceDelegateController.h"
#import "UIViewController+ShowView.h"
#import "DefineValue.h"

@class YWLoginViewController;
@class YWRegistViewController;

@interface FastLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *textField;
@property (nonatomic, strong) UITextField   *verifyCodeField;

@property (nonatomic, strong) UIButton      *loginBtn;

@end

@implementation FastLoginViewController
{
    NSString *uuid;
    NSInteger timeout;
    NSTimer *downTimer;
    UIButton *getVerifyCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title = @"手机号快捷登录";
    self.showShadow = YES;
    [self setShadowColor:[UIColor lightGrayColor]];
    [self createView];
}

- (void)showAlertViewTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVC animated:YES completion:^{
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timerFireMethod:) userInfo:alertVC repeats:NO];
    }];
}

#pragma mark 定时器
- (void)timerFireMethod:(NSTimer *)timer {
    UIAlertController *alertVC = [timer userInfo];
    [alertVC dismissViewControllerAnimated:YES completion:nil];
    if (alertVC.title == nil) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"] == YES) {
            YWTabBarController *tabBarVC = [[YWTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    self.loginBtn.enabled = YES;
}

- (void)getVerifyCode {
    [self.textField resignFirstResponder];
    
    if (![RegularTools validateMobile:self.textField.text]) {//手机号验证
        
        [self showAlertViewTitle:@"提示" message:@"请输入正确的手机号"];
        
        return;
    }
    
    uuid = [Interface uuid];
    
    //type == 0：注册；1：登录；2:找回密码
    NSArray *sendverify = [Interface appsendverfcode:self.textField.text type:@"1" uuid:uuid];
    [MyNetworker POST:sendverify[InterfaceUrl] parameters:sendverify[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self showAlertViewTitle:@"提示" message:@"验证码已发送，请注意查收"];
            [self startTimer];
            
        } else {
            [self showAlertViewTitle:@"提示" message:@"发送验证码失败，请检查手机号"];
        }
        
    } failure:^(NSError *error) {
        [self showAlertViewTitle:@"提示" message:@"网络错误"];
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
        [getVerifyCode setTitle:@"  发送验证码  " forState:UIControlStateNormal];
        getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
        [downTimer invalidate];
    }
}

#pragma mark 校验验证码
- (void)commitVerifyCode {
    
    if (self.verifyCodeField.text.length != 4) {
        [self showAlertViewTitle:@"提示" message:@"请输入正确的4位验证码"];
        return;
    }
    
    //    //type == 0：注册；1：登录；2:找回密码
    NSArray *checkcode = [Interface appcheckverfcode:self.textField.text mobile:self.textField.text verf_code:self.verifyCodeField.text type:@"1" uuid:uuid];
    [MyNetworker POST:checkcode[InterfaceUrl] parameters:checkcode[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self login];
            
        } else {
            [self showAlertViewTitle:@"提示" message:@"验证码错误，请重新输入"];
        }
    } failure:^(NSError *error) {
        [self showAlertViewTitle:@"提示" message:@"网络错误"];
    }];
      
}


#pragma mark 登录
- (void)login {
    [self.view endEditing:YES];
    
    [self clickDisable];
        
    if (self.textField.text.length == 0 || self.verifyCodeField.text.length == 0) {
        [self clickEnable];
        [self showAlertViewTitle:@"提示" message:@"手机号和验证码不能为空"];
        return;
    }
    
    NSArray *login = [Interface applogin:self.textField.text password:@"" type:@"1" verf_code:self.verifyCodeField.text uuid:uuid];
    [MyNetworker POST:login[InterfaceUrl] parameters:login[Parameters] success:^(id responseObject) {
        [self clickEnable];
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            
            //登录成功后,保存数据,返回个人中心
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
            
            [self showAlertViewTitle:nil message:@"登录成功"];
        } else {
            [self showAlertViewTitle:@"提示" message:@"登录失败，请检查验证码"];
        }
    } failure:^(NSError *error) {
        [self clickEnable];
        [self showAlertViewTitle:@"提示" message:@"网络错误"];
    }];
    
}

- (void)createView {
    UIFont *font = [UIFont systemFontOfSize:14];
    
    self.textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"请输入手机号码" isSecure:NO];
    self.textField.clearButtonMode = UITextFieldViewModeNever;
    self.textField.keyboardType = UIKeyboardTypePhonePad;
    self.textField.returnKeyType = UIReturnKeySend;
    self.textField.font = font;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.verifyCodeField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"请输入短信验证码" isSecure:NO];
    self.verifyCodeField.returnKeyType = UIReturnKeyDone;
    self.verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyCodeField.font = font;
    self.verifyCodeField.delegate = self;
    [self.view addSubview:self.verifyCodeField];
    
    [self.verifyCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).with.offset(1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.loginBtn = [YWPublic createButtonWithFrame:CGRectZero title:@"验证并登录" imageName:nil];
    self.loginBtn.titleLabel.font = font;
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(commitVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
        
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeField.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *tipsLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    tipsLabel.titleLabel.font = [UIFont systemFontOfSize:14];
    tipsLabel.titleLabel.numberOfLines = 0;
    [tipsLabel setTitle:@"温馨提示：未注册易务车宝账号的手机号，登录时将自动注册易务车宝，代表您已同意《易务车宝用户协议》" forState:UIControlStateNormal ];
    [tipsLabel setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    [tipsLabel addTarget:self action:@selector(showUserAgreements) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.loginBtn.mas_left);
        make.right.mas_equalTo(self.loginBtn.mas_right);
    }];
    
    getVerifyCode = [YWPublic createButtonWithFrame:CGRectZero title:@"  发送验证码  " imageName:nil];
    getVerifyCode.titleLabel.font = font;
    
    //设置颜色
    [getVerifyCode setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
    getVerifyCode.layer.borderWidth = 1.0;
    getVerifyCode.layer.cornerRadius = 6;
    getVerifyCode.clipsToBounds = YES;
    
    [getVerifyCode addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerifyCode];
    
    [getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginBtn.mas_right);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.textField);
    }];
    
}

- (void)showUserAgreements {
    ServiceDelegateController *serviceVC = [[ServiceDelegateController alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == self.textField) {
        [self getVerifyCode];
    } else {
        [self loginBtn];
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
