//
//  UserCenterFunc.h
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserCenterFunc : NSObject

//背景
- (UIView *)createBackgroundViewAtView:(UIView *)view height:(CGFloat)height;

//头像
- (UIImageView *)createUserImageView:(CGSize)size left:(CGFloat)left bottom:(CGFloat)bottom;

//用户名
- (UIButton *)createUserNameButton:(UIViewController *)target title:(NSString *)title imageView:(UIImageView *)imageView left:(CGFloat)left;

//信息
- (UIButton *)createMessageImage:(UIViewController *)target image:(NSString *)imageName size:(CGSize)size top:(CGFloat)top right:(CGFloat)right;

//设置
- (void)createSettingImage:(UIViewController *)target image:(NSString *)imageName size:(CGSize)size right:(CGFloat)right;

@end
