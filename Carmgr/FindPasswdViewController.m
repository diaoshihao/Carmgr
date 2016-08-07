//
//  FindPasswdViewController.m
//  Carmgr
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "FindPasswdViewController.h"
#import <Masonry.h>
#import "YWPublic.h"
#import "ResetPasswdViewController.h"

@interface FindPasswdViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *verifyCodeField;

@end

@implementation FindPasswdViewController
{
    NSString *uuid;//只在getverfcode中获取，保证每个验证码对应一个uuid
    UIButton *getVerifyCode;
    NSInteger timeout;
    NSTimer *downTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self customLeftItem];
    
    [self createView];
    
}

#pragma mark 校验验证码
- (void)verifyCode {
    if (self.verifyCodeField.text.length == 0 || self.textField.text.length == 0) {
        [self showAlertViewTitle:@"提示" message:@"手机号或验证码不能为空"];
        return;
    }

    //type == 0：注册；1：登录；2:找回密码
    NSString *urlStr = [NSString stringWithFormat:kCHECKVERFCODE,self.textField.text,self.textField.text,self.verifyCodeField.text,2,uuid];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            
            [self pushToResetView];
            
        } else {
            [self showAlertViewTitle:@"提示" message:@"验证码错误，请重新输入"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertViewTitle:@"提示" message:@"网络错误"];
        NSLog(@"%@",error);
    }];

}

//验证码通过后到设置密码界面
- (void)pushToResetView {
    ResetPasswdViewController *resetPasswdVC = [[ResetPasswdViewController alloc] init];
    resetPasswdVC.username = self.textField.text;
    resetPasswdVC.mobile = self.textField.text;
    resetPasswdVC.verifycode = self.verifyCodeField.text;
    resetPasswdVC.uuid = uuid;
    [self.navigationController pushViewController:resetPasswdVC animated:YES];
}

- (void)getVerifyCode {
    [self.textField resignFirstResponder];
    
    uuid = [[NSUUID UUID] UUIDString];
    
    if (![RegularTools validateMobile:self.textField.text]) {//手机号验证
        [self showAlertViewTitle:@"提示" message:@"请输入正确的手机号"];
    } else {
        //type == 0：注册；1：登录；2:找回密码
        NSString *urlStr = [NSString stringWithFormat:kVERIFYCODE,self.textField.text,2,uuid];
        
        [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
                [self showAlertViewTitle:@"提示" message:@"验证码已发送，请注意查收"];
                [self startTimer];
            } else {
                [self showAlertViewTitle:@"提示" message:@"发送验证码失败,请检查手机号"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertViewTitle:@"提示" message:@"网络错误"];
        }];
    }
}

- (void)startTimer {
    timeout = 60;
    getVerifyCode.enabled = NO;
    downTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonState) userInfo:nil repeats:YES];
}

- (void)changeButtonState {
    timeout--;
    [getVerifyCode setTitle:[NSString stringWithFormat:@"  %ld秒后可重新发送  ",timeout] forState:UIControlStateDisabled];
    [getVerifyCode setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    getVerifyCode.layer.borderColor = [UIColor grayColor].CGColor;
    if (timeout == 0) {
        getVerifyCode.enabled = YES;
        [getVerifyCode setTitle:@"  发送验证码  " forState:UIControlStateNormal];
        getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
        [downTimer invalidate];
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
}

- (void)customLeftItem {
    self.navigationItem.title = @"找回密码";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView {
    UIFont *font = [UIFont systemFontOfSize:14];
    
    self.textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"请输入手机号码" isSecure:NO];
    self.textField.clearButtonMode = UITextFieldViewModeNever;
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
    
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"验证" imageName:nil];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(verifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeField.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
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
        make.right.mas_equalTo(button.mas_right);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.textField);
    }];

}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == self.textField) {
        [self getVerifyCode];
    } else {
        [self verifyCode];
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
