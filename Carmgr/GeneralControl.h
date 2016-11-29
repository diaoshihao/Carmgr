//
//  GeneralControl.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralControl : UIView


/**
 按钮的图文上下分布
 @param imageName   图片名
 @param title       标题
 @return            返回按钮
 */
+ (UIButton *)buttonWithUpperImage:(NSString *)imageName lowerTitle:(NSString *)title;

/**
 按钮的图片在右边
 @param imageName   图片名
 @param title       标题
 @return            返回按钮
 */
+ (UIButton *)buttonWithRightImage:(NSString *)imageName title:(NSString *)title;

/**
 缩进两格的TextField

 @param placeholder 占位符

 @return TextField
 */
+ (UITextField *)twoSpaceTextField:(NSString *)placeholder;

/**
 只有图片的Button

 @param imageName 图片名

 @return Button
 */
+ (UIButton *)imageButton:(NSString *)imageName;

/**
 登录按钮类型的Button

 @param title 标题

 @return Button
 */
+ (UIButton *)loginTypeButton:(NSString *)title;


/**
 UIAlertController

 @param title   标题
 @param message 信息

 @return UIAlertController
 */
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message;

/**
 imagePickerController

 @param sourceType 资源类型
 @param delegate   代理方

 @return imagePickerController
 */
+ (UIImagePickerController *)imagePickerControllerWithSourType:(UIImagePickerControllerSourceType)sourceType delegate:(id)delegate;
@end
