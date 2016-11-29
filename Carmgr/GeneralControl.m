//
//  GeneralControl.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "GeneralControl.h"
#import "DefineValue.h"

@implementation GeneralControl

+ (UIButton *)buttonWithUpperImage:(NSString *)imageName lowerTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height + 10, (button.intrinsicContentSize.width - button.imageView.intrinsicContentSize.width)/2, button.titleLabel.intrinsicContentSize.height - 10, -(button.intrinsicContentSize.width - button.imageView.intrinsicContentSize.width)/2)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.intrinsicContentSize.height - 10, -(button.intrinsicContentSize.width - button.titleLabel.intrinsicContentSize.width)/2, -button.imageView.intrinsicContentSize.height + 10, (button.intrinsicContentSize.width - button.titleLabel.intrinsicContentSize.width)/2)];
    return button;
}

+ (UIButton *)buttonWithRightImage:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.intrinsicContentSize.width, 0, button.imageView.intrinsicContentSize.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.intrinsicContentSize.width, 0, -button.titleLabel.intrinsicContentSize.width)];
    return button;
}

+ (UITextField *)twoSpaceTextField:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = placeholder;
    textField.textColor = kColor(102, 102, 102, 1);
    textField.font = [DefineValue font15];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (UIButton *)imageButton:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeLeft;
    button.contentHorizontalAlignment = UIViewContentModeLeft;
    return button;
}

+ (UIButton *)loginTypeButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [DefineValue font16];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    return button;
}

+ (UIAlertController *)customAlertTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    return alertVC;
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:sureBtn];
    return alertVC;
}

+ (UIImagePickerController *)imagePickerControllerWithSourType:(UIImagePickerControllerSourceType)sourceType delegate:(id)delegate {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = delegate;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = sourceType;
    return imagePicker;
}


@end
