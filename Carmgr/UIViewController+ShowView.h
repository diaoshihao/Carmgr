//
//  UIViewController+ShowView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/11/11.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShowView)

- (BOOL)isLogin;

- (NSString *)currentCity;


- (void)showAlertOnlyMessage:(NSString *)message;

- (void)alertDismissAfter:(NSUInteger)timeout message:(NSString *)message;


//无网络提示
- (void)noConnect;

//网络请求错误提示
- (void)connectError;

//服务返回失败信息提示
- (void)connectFailed;

//正在...
- (UIView *)loading:(NSString *)text;

//成功提示
- (UIView *)success:(NSString *)text dismiss:(NSUInteger)timeout;


- (void)clickEnable;

- (void)clickAble;


@end
