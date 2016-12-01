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
