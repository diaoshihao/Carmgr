//
//  RegistView.h
//  Carmgr
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RegistStep) {
    RegistStepInputPhoneNum = 0,    //输入手机号
    RegistStepInputVerifyCode = 1,  //输入验证码
    RegistStepSetSecure = 2         //设置密码
};

@interface RegistView : UIView

- (UIView *)createSelectViewAtSuperView:(UIView *)superView registStep:(RegistStep)step;


- (UITextField *)createTextFieldAtSuperView:(UIView *)superView broView:(UIView *)broView placeholder:(NSString *)placeholder;

- (UIButton *)createButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView title:(NSString *)title target:(UIViewController *)target action:(SEL)selector;

- (UILabel *)createInfoLabelAtSuperView:(UIView *)superView phoneNum:(NSString *)phoneNum broview:(UIView *)broview;

- (void)createAgreementViewAtSuperView:(UIView *)superView broview:(UIView *)broview;

@end
