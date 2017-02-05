//
//  AlertShowAssistant.m
//  Carmgr
//
//  Created by admin on 2017/2/5.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "AlertShowAssistant.h"

@implementation AlertShowAssistant

+ (void)alertTip:(NSString *)tip message:(NSString *)message actionTitle:(NSString *)title defaultHandle:(void (^)(void))defaultHandle cancelHandle:(void (^)(void))cancelHandle {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:tip message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (defaultHandle != nil) {
        UIAlertAction *sure = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (defaultHandle) {
                defaultHandle();
            }
        }];
        [alert addAction:sure];
    }
    
    if (cancelHandle != nil) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandle) {
                cancelHandle();
            }
        }];
        [alert addAction:cancel];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
