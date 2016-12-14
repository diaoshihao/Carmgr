//
//  ResetPasswdViewController.m
//  Carmgr
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ResetPasswdViewController.h"
#import <Masonry.h>
#import "YWPublic.h"

@interface ResetPasswdViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *setNewPasswd;
@property (nonatomic, strong) UITextField *verifyPasswd;

@end

@implementation ResetPasswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title = @"设置密码";
    self.showShadow = YES;
    [self setShadowColor:[UIColor lightGrayColor]];
    [self createView];
}

//重置密码
- (void)beginCommit {
    [self.view endEditing:YES];
    
    //确认两次输入一致
    if (self.setNewPasswd.text != self.verifyPasswd.text) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码输入不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.setNewPasswd becomeFirstResponder];
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        [self resetPassword];//重设密码
    }
    
}

#pragma mark - 网络请求
- (void)resetPassword {
    if (self.setNewPasswd.text.length < 6) {
        [self showAlertViewTitle:@"提示" messae:@"密码不能少于6位数"];
    } else {
        [YWPublic afPOST:[[NSString stringWithFormat:kRESETPASSWD,self.username,self.setNewPasswd.text,self.uuid,self.verifycode,2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
                [self showAlertViewTitle:nil messae:@"修改密码成功"];
                
            } else {
                [self showAlertViewTitle:@"提示" messae:@"修改密码失败"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertViewTitle:@"提示" messae:@"网络错误"];
        }];
    }
}

- (void)showAlertViewTitle:(NSString *)title messae:(NSString *)message {
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
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)createView {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    self.setNewPasswd = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"新密码" isSecure:NO];
    self.setNewPasswd.returnKeyType = UIReturnKeyNext;
    self.setNewPasswd.font = font;
    self.setNewPasswd.delegate = self;
    [self.view addSubview:self.setNewPasswd];
    
    [self.setNewPasswd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.verifyPasswd = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"确认新密码" isSecure:NO];
    self.verifyPasswd.returnKeyType = UIReturnKeyDone;
    self.verifyPasswd.font = font;
    self.verifyPasswd.delegate = self;
    [self.view addSubview:self.verifyPasswd];
    
    [self.verifyPasswd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.setNewPasswd.mas_bottom).with.offset(1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"确认提交" imageName:nil];
    button.titleLabel.font = font;
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(beginCommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyPasswd.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == self.setNewPasswd) {
        [self.verifyPasswd becomeFirstResponder];
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
