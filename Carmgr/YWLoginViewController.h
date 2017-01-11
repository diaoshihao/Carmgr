//
//  YWLoginViewController.h
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "BasicViewController.h"
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, LoginOption) {
    LoginOptionAuto,    //自动登录
    LoginOptionNormal,  //正常登录
    LoginOptionRelogin, //重新登录
};

@interface YWLoginViewController : BasicViewController

@property (nonatomic, assign) LoginOption loginOption;

@property (nonatomic, assign) BOOL cancelBtnHidden;

@end
