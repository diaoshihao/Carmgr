//
//  BasicViewController.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

/**
 * 基类
 */

#import <UIKit/UIKit.h>
#import "DefineValue.h"
#import "CustomButton.h"
#import <Masonry.h>

@interface BasicViewController : UIViewController

@property (nonatomic, strong) UIView *customNavBar;

@property (nonatomic, strong) UILabel *barTitleLabel;

@property (nonatomic, strong) CustomButton *leftItemButton;

@property (nonatomic, strong) CustomButton *rightItemButton;

@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, assign) BOOL allowGesture;

@property (nonatomic, assign) BOOL showShadow;

- (void)setShadowColor:(UIColor *)color;

- (void)configRightItemView;

- (void)configLeftItemView;

@end
