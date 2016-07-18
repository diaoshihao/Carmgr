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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self customLeftItem];
    
    [self createView];
    
}

- (void)verifyCode {
    NSLog(@"验证通过");
    ResetPasswdViewController *resetPasswdVC = [[ResetPasswdViewController alloc] init];
    [self.navigationController pushViewController:resetPasswdVC animated:YES];
}

- (void)getVerifyCode {
    [self.textField resignFirstResponder];
    //网络请求获取验证码   参数：username=%@&type=%@&version=1.0
    //type == 0：注册；1：登录；2:找回密码
    
    [YWPublic afPOST:[NSString stringWithFormat:kVERIFYCODE,self.textField.text,2] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dataDict);
//        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
//            [self verifyCode];//验证通过
//        } else {
//            NSLog(@"%@",dataDict[@"opt_info"]);
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)customLeftItem {
    self.navigationItem.title = @"找回密码";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentMode = UIViewContentModeLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    self.textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"请输入手机号码" isSecure:NO];
    self.textField.returnKeyType = UIReturnKeyNext;
    self.textField.font = font;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    self.verifyCodeField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"请输入短信验证码" isSecure:NO];
    self.verifyCodeField.returnKeyType = UIReturnKeyDone;
    self.verifyCodeField.font = font;
    self.verifyCodeField.delegate = self;
    [self.view addSubview:self.verifyCodeField];
    
    [self.verifyCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).with.offset(1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"验证" imageName:nil];
    button.titleLabel.font = font;
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(verifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyCodeField.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *getVerifyCode = [YWPublic createButtonWithFrame:CGRectZero title:@"  发送验证码  " imageName:nil];
    getVerifyCode.titleLabel.font = font;
    
    //设置颜色
    [getVerifyCode setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
    getVerifyCode.layer.borderWidth = 1.0;
    getVerifyCode.layer.cornerRadius = 6;
    getVerifyCode.clipsToBounds = YES;
    
    [getVerifyCode addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    [self.textField addSubview:getVerifyCode];
    
    [getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.textField);
    }];

}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == self.textField) {
        [self.verifyCodeField becomeFirstResponder];
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