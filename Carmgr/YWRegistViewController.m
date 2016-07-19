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

@interface YWRegistViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneNum;
@property (nonatomic, strong) UITextField *verifyCode;
@property (nonatomic, strong) UITextField *passwdField;
@property (nonatomic, strong) UITextField *repeatPasswd;

@property (nonatomic, strong) RegistView  *registView;

@property (nonatomic, strong) NSString *mobile;

@end

@implementation YWRegistViewController

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
    self.navigationItem.title = @"注册";
    
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
    self.phoneNum.returnKeyType = UIReturnKeyNext;
    UIButton *button = [self.registView createButtonAtSuperView:self.view Constraints:self.phoneNum title:@"获取验证码" target:self action:@selector(getVerifyCode)];
    
    //同意平台协定
    [self.registView createAgreementViewAtSuperView:self.view broview:button target:self action:@selector(serviceDelegate)];
    
}

- (void)serviceDelegate {
    ServiceDelegateController *serviceDelegateVC = [[ServiceDelegateController alloc] init];
    [self.navigationController pushViewController:serviceDelegateVC animated:YES];
}

#pragma mark 获取验证码
- (void)getVerifyCode {
    BOOL correct = [RegularTools validateMobile:self.phoneNum.text];
    if (correct) {
        
        //网络请求获取验证码   参数：username=%@&type=%@&version=1.0
        //type == 0：注册；1：登录；2:找回密码
        
        [YWPublic afPOST:[NSString stringWithFormat:kVERIFYCODE,self.phoneNum.text,0] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"网络请求成功%@",dataDict);
            
            if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
                self.mobile = self.phoneNum.text;
                [self removeAllSubviews];
                [self createInputVerifyCodeView];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
        
    } else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFireMethod:) userInfo:alertVC repeats:NO];
        }];
    }
}

//重新获取验证码
- (void)regetVerifyCode {
    [self getVerifyCode];
}

#pragma mark 定时器
- (void)timerFireMethod:(NSTimer *)timer {
    UIAlertController *alertVC = [timer userInfo];
    [alertVC dismissViewControllerAnimated:YES completion:nil];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self.registView regetVerifyCode:self action:@selector(regetVerifyCode)]];
}

#pragma mark 
- (void)commitVerifyCode {
    [self removeAllSubviews];
    [self createSetSecureView];
}

#pragma mark 设置密码
- (void)createSetSecureView {
    self.navigationItem.rightBarButtonItem = nil;
    
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
    if (self.passwdField.text.length <= 32 && self.passwdField.text.length >= 6 && [self.passwdField.text isEqualToString:self.repeatPasswd.text]) {
        
        //注册
        [YWPublic afPOST:[NSString stringWithFormat:kREGISTER,self.mobile,self.passwdField.text,self.mobile,0] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
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
