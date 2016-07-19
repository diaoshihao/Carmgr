//
//  ResetPasswdViewController.h
//  Carmgr
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SetPasswordType) {
    ForResetPassword = 0,//重设密码
    ForFindPassword = 1  //找回密码
};

@interface ResetPasswdViewController : UIViewController

@property (nonatomic) SetPasswordType settingType;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *verifycode;

@end
