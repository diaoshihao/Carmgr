//
//  LoginView.m
//  Carmgr
//
//  Created by admin on 16/6/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "LoginView.h"
#import "YWPublic.h"
#import <Masonry.h>

@interface LoginView()

@end

@implementation LoginView

- (UIBarButtonItem *)createBarButtonItem:(CGRect)frame title:(NSString *)title target:(UIViewController *)target action:(SEL)selector {
    UIButton *barButton = [YWPublic createButtonWithFrame:frame title:title imageName:nil];
    [barButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    barButton.titleLabel.font = [UIFont systemFontOfSize:15];
    return item;
}

- (UITextField *)createTextFieldAtSuperView:(UIView *)superView Constraints:(UIView *)broView isUserField:(BOOL)isUserField {
    UIFont *font = [UIFont systemFontOfSize:14];
    
    if (isUserField) {
        UITextField *textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"手机/邮箱/用户名" isSecure:NO];
        textField.returnKeyType = UIReturnKeyNext;
        textField.font = font;
        [superView addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(superView).with.offset(74);
            make.left.mas_equalTo(superView).with.offset(0);
            make.right.mas_equalTo(superView).with.offset(0);
            make.height.mas_equalTo(44);
        }];
        return textField;
    } else {
        UITextField *textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"密码" isSecure:YES];
        textField.returnKeyType = UIReturnKeyDone;
        textField.font = font;
        [superView addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(broView.mas_bottom).with.offset(1);
            make.left.mas_equalTo(superView).with.offset(0);
            make.right.mas_equalTo(superView).with.offset(0);
            make.height.mas_equalTo(44);
        }];
        return textField;
    }
    
}

- (UIButton *)createLoginButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView target:(UIViewController *)target action:(SEL)selector {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIButton *loginBtn = [YWPublic createButtonWithFrame:CGRectZero title:@"登录" imageName:nil];
    loginBtn.titleLabel.font = font;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [loginBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(superView).with.offset(15);
        make.right.mas_equalTo(superView).with.offset(-15);
        make.height.mas_equalTo(44);
    }];
    return loginBtn;
}

- (void)createButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView target:(UIViewController *)target action:(SEL)selector forPasswd:(BOOL)forPasswd {
    UIFont *font = [UIFont systemFontOfSize:14];
    
    if (forPasswd) {
        UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"找回密码" imageName:nil];
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = font;
        [button setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        [superView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(broView.mas_bottom).with.offset(20);
            make.left.mas_equalTo(broView.mas_left).with.offset(0);
            
            CGSize size = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
            make.size.mas_equalTo(size);
        }];
    } else {
        UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"手机快捷登录" imageName:nil];
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = font;
        [button setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        [superView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(broView.mas_bottom).with.offset(20);
            make.right.mas_equalTo(broView.mas_right).with.offset(0);
            
            CGSize size = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
            make.size.mas_equalTo(size);
        }];
    }
}

- (void)createThirdLoginAtSuperView:(UIView *)superView target:(UIViewController *)target action:(SEL)selector {
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"使用第三方账号登录";
    tipsLabel.textColor = [UIColor grayColor];
    tipsLabel.font = [UIFont systemFontOfSize:14];
    [superView addSubview:tipsLabel];
    
    UIButton *QQLogin = [[UIButton alloc] init];
    [QQLogin setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    QQLogin.tag = 100;
    [QQLogin addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:QQLogin];
    
    UIButton *wechatLogin = [[UIButton alloc] init];
    [wechatLogin setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    wechatLogin.tag = 200;
    [wechatLogin addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:wechatLogin];
    
    [QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-30);
        make.right.mas_equalTo(superView.mas_centerX).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [wechatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-30);
        make.left.mas_equalTo(superView.mas_centerX).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [tipsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [tipsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(QQLogin.mas_top).with.offset(-15);
        make.centerX.mas_equalTo(superView);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
