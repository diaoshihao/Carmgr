//
//  UIViewController+ShowView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/11/11.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "UIViewController+ShowView.h"
#import "GeneralControl.h"

@implementation UIViewController (ShowView)

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *alertVC = [GeneralControl alertWithTitle:@"提示" message:message];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)alertDismissAfter:(NSUInteger)timeout message:(NSString *)message {
    UIAlertController *alertVC = [GeneralControl alertWithTitle:nil message:message];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

- (void)noConnect {
    
}

- (void)connectError {
//    if (![PPNetworkHelper currentNetworkStatus]) {
//        [self showAlertMessage:@"似乎已断开与互联网的连接"];
//    } else {
//        [self showAlertMessage:@"请求出错，请稍后再试"];
//    }
}

- (void)connectFailed {
    
}

///////////////////////////////////////////////////////////////////////
- (UIView *)loading:(NSString *)text {
    UIButton *progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
    [progressHUD setBackgroundColor:[UIColor clearColor]];
    
    UIView *HUDContainer = [[UIView alloc] init];
    HUDContainer.frame = CGRectMake((self.view.bounds.size.width - 120) / 2, (self.view.bounds.size.height - 90) / 2, 120, 90);
    HUDContainer.layer.cornerRadius = 8;
    HUDContainer.clipsToBounds = YES;
    HUDContainer.backgroundColor = [UIColor darkGrayColor];
    HUDContainer.alpha = 0.7;
    
    UIActivityIndicatorView *HUDIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    HUDIndicatorView.frame = CGRectMake(45, 15, 30, 30);
    
    UILabel *HUDLable = [[UILabel alloc] init];
    HUDLable.frame = CGRectMake(0,40, 120, 50);
    HUDLable.textAlignment = NSTextAlignmentCenter;
    HUDLable.text = text;
    HUDLable.font = [UIFont systemFontOfSize:15];
    HUDLable.textColor = [UIColor whiteColor];
    
    [HUDContainer addSubview:HUDLable];
    [HUDContainer addSubview:HUDIndicatorView];
    [progressHUD addSubview:HUDContainer];
    
    [HUDIndicatorView startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview:progressHUD];
    
    // if over time, dismiss HUD automatic
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUDIndicatorView stopAnimating];
        [progressHUD removeFromSuperview];
    });
    return progressHUD;
}

- (UIView *)success:(NSString *)text dismiss:(NSUInteger)timeout {
    UIButton *progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
    [progressHUD setBackgroundColor:[UIColor clearColor]];
    
    UIView *HUDContainer = [[UIView alloc] init];
    HUDContainer.frame = CGRectMake((self.view.bounds.size.width - 120) / 2, (self.view.bounds.size.height - 90) / 2, 120, 90);
    HUDContainer.layer.cornerRadius = 8;
    HUDContainer.clipsToBounds = YES;
    HUDContainer.backgroundColor = [UIColor darkGrayColor];
    HUDContainer.alpha = 0.7;
    
    UILabel *HUDLable = [[UILabel alloc] init];
    HUDLable.frame = CGRectMake(0,20, 120, 50);
    HUDLable.textAlignment = NSTextAlignmentCenter;
    HUDLable.text = text;
    HUDLable.font = [UIFont systemFontOfSize:15];
    HUDLable.textColor = [UIColor whiteColor];
    
    [HUDContainer addSubview:HUDLable];
    [progressHUD addSubview:HUDContainer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:progressHUD];
    
    // if over time, dismiss HUD automatic
    NSUInteger time = timeout == 0 ? 5 : timeout;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressHUD removeFromSuperview];
    });
    return progressHUD;
}


@end
