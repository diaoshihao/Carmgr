//
//  UserCenterFunc.m
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserCenterFunc.h"
#import "YWPublic.h"
#import <Masonry.h>

@interface UserCenterFunc()

@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIButton    *userName;
@property (nonatomic, strong) UIButton    *messageButton;

@end

@implementation UserCenterFunc

#pragma mark 背景
- (UIView *)createBackgroundViewAtView:(UIView *)view height:(CGFloat)height {
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    [view addSubview:self.backView];
    
    __weak typeof(self) weakSelf = self; // 防止block循环引用
    [weakSelf.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).with.offset(0);
        make.left.mas_equalTo(view).with.offset(0);
        make.right.mas_equalTo(view).with.offset(0);
        make.height.mas_equalTo(height);
    }];
    return self.backView;
}

#pragma mark 头像
- (UIImageView *)createUserImageView:(CGSize)size left:(CGFloat)left bottom:(CGFloat)bottom {
    self.userImageView = [YWPublic createCycleImageViewWithFrame:CGRectZero image:@"头像大"];
    [self.backView addSubview:self.userImageView];
    
    //自动布局
    __weak typeof(self) weakSelf = self; // 防止block循环引用
    [weakSelf.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.left.mas_equalTo(weakSelf.backView).with.offset(left);
        make.bottom.mas_equalTo(weakSelf.backView).with.offset(bottom);
    }];
    return self.userImageView;
}

#pragma mark 用户名
- (UIButton *)createUserNameButton:(UIViewController *)target title:(NSString *)title imageView:(UIImageView *)userImageView left:(CGFloat)left {
    
    //用户名
    self.userName = [YWPublic createButtonWithFrame:CGRectZero title:title imageName:nil];
    [self.userName addTarget:target action:@selector(pushToLoginVC) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.userName];
    
    __weak typeof(self) weakSelf = self; // 防止block循环引用
    [weakSelf.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userImageView.mas_right).with.offset(left);
        //根据字数自动调整大小
        CGSize titleSize = [weakSelf.userName.currentTitle sizeWithAttributes:@{NSFontAttributeName:weakSelf.userName.titleLabel.font}];
        make.size.mas_equalTo(CGSizeMake(titleSize.width, titleSize.height));
        make.centerY.mas_equalTo(weakSelf.userImageView);
    }];
    return self.userName;
}

#pragma mark 信息
- (UIButton *)createMessageImage:(UIViewController *)target image:(NSString *)imageName size:(CGSize)size top:(CGFloat)top right:(CGFloat)right {
    self.messageButton = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:imageName];
    [self.backView addSubview:self.messageButton];
    
    __weak typeof(self) weakSelf = self; // 防止block循环引用
    [weakSelf.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backView).with.offset(top);
        make.size.mas_equalTo(size);
        make.right.mas_equalTo(weakSelf.backView).with.offset(right);
    }];
    return self.messageButton;
}

#pragma mark 设置
- (void)createSettingImage:(UIViewController *)target image:(NSString *)imageName size:(CGSize)size right:(CGFloat)right {
    UIButton *settingButton = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:imageName];
    [self.backView addSubview:settingButton];
    
    __weak typeof(self) weakSelf = self; // 防止block循环引用
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.right.mas_equalTo(weakSelf.messageButton.mas_left).with.offset(right);
        make.centerY.mas_equalTo(weakSelf.messageButton);
    }];

}

- (void)pushToLoginVC {
    
}

@end
