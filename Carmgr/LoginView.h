//
//  LoginView.h
//  Carmgr
//
//  Created by admin on 16/6/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

//导航栏按钮
- (UIBarButtonItem *)createBarButtonItem:(CGRect)frame title:(NSString *)title target:(UIViewController *)target action:(SEL)selector;

//用户名和密码输入框
- (UITextField *)createTextFieldAtSuperView:(UIView *)superView Constraints:(UIView *)broView isUserField:(BOOL)isUserField;

//登录按钮
- (UIButton *)createLoginButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView target:(UIViewController *)target action:(SEL)selector;

//找回密码、快捷登录
- (void)createButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView target:(UIViewController *)target action:(SEL)selector forPasswd:(BOOL)forPasswd;

//第三方登录
- (void)createThirdLoginAtSuperView:(UIView *)superView target:(UIViewController *)target action:(SEL)selector;

@end
