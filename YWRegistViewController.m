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
    self.view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    self.navigationItem.title = @"注册";
    
    [self createInputPhoneNumView];
    
}

//移除所有子视图
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
    [self.registView createAgreementViewAtSuperView:self.view broview:button];
    
}

#pragma mark
- (void)getVerifyCode {
    if (!(self.phoneNum.text.length == 11)) {
        self.mobile = self.phoneNum.text;
        [self removeAllSubviews];
        [self createInputVerifyCodeView];
    } else {
        NSLog(@"判断语句中添加手机号正则表达式");
    }
}

#pragma mark - 输入验证码
- (void)createInputVerifyCodeView {
    UIView *view = [self.registView createSelectViewAtSuperView:self.view registStep:RegistStepInputVerifyCode];
    UILabel *label = [self.registView createInfoLabelAtSuperView:self.view phoneNum:self.phoneNum.text broview:view];
    self.verifyCode = [self.registView createTextFieldAtSuperView:self.view broView:label placeholder:@"请输入短信中的验证码"];
    self.verifyCode.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyCode.returnKeyType = UIReturnKeyNext;
    [self.registView createButtonAtSuperView:self.view Constraints:self.verifyCode title:@"提交验证码" target:self action:@selector(commitVerifyCode)];
    
}

#pragma mark 
- (void)commitVerifyCode {
    [self removeAllSubviews];
    [self createSetSecureView];
}

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

- (void)regist {
    if (self.passwdField.text.length <= 32 && self.passwdField.text.length >= 6 && [self.passwdField.text isEqualToString:self.repeatPasswd.text]) {
        
        //注册
        NSString *param = [NSString stringWithFormat:@"username=%@&password=%@&mobile=%@",self.mobile,self.passwdField.text,self.mobile];
        [YWPublic afPOST:kREGISTER parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSLog(@"%@ %@ %@",self.mobile,self.passwdField.text,self.mobile);
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