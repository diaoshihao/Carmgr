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

@property (nonatomic, strong) UITextField *userField;
@property (nonatomic, strong) UITextField *secureField;

@end

@implementation LoginView

- (UIBarButtonItem *)createBarButtonItem:(CGRect)frame title:(NSString *)title target:(UIViewController *)target action:(SEL)selector {
    UIButton *barButton = [YWPublic createButtonWithFrame:frame title:title imageName:nil];
    [barButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    return item;
}

- (UITextField *)createTextFieldAtSuperView:(UIView *)superView Constraints:(UIView *)broView isUserField:(BOOL)isUserField {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    if (isUserField) {
        UITextField *textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:@"手机/邮箱/用户名" isSecure:NO];
        textField.returnKeyType = UIReturnKeyNext;
        textField.font = font;
        [superView addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(superView).with.offset(74);
            make.left.mas_equalTo(superView).with.offset(0);
            make.right.mas_equalTo(superView).with.offset(0);
            make.height.mas_equalTo(35);
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
            make.height.mas_equalTo(35);
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
        make.height.mas_equalTo(broView.mas_height);
    }];
    return loginBtn;
}

- (void)createButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView target:(UIViewController *)target action:(SEL)selector forPasswd:(BOOL)forPasswd {
    UIFont *font = [UIFont systemFontOfSize:15];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
