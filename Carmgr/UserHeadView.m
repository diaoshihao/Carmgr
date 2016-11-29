//
//  UserHeadView.m
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserHeadView.h"
#import "DefineValue.h"
#import "YWPublic.h"
#import <Masonry.h>

@interface UserHeadView()

@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *messageButton;

@end

@implementation UserHeadView {
    CGFloat _width;
    CGFloat _height;
    CGFloat _imageHeight;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [DefineValue mainColor];
        _width = self.frame.size.width;
        _height = _width / 2.5;
        _imageHeight = _height / 2;
        [self createHeadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [DefineValue mainColor];
        _width = self.frame.size.width;
        _height = _width / 2.5;
        _imageHeight = _height / 2;
        [self createHeadView];
    }
    return self;
}

- (void)createHeadView {
    //头像
    self.userImageView = [YWPublic createCycleImageViewWithFrame:CGRectZero image:nil placeholder:@"头像"];
    [self addSubview:self.userImageView];
    
    //用户名
    NSString *username = nil;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"] == NO) {
        username = @"登录/注册";
    } else {
        username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    }
    self.userName = [YWPublic createButtonWithFrame:CGRectZero title:username imageName:nil];
    self.userName.tag = ButtonUserName;
    [self.userName addTarget:self action:@selector(pushToMessagePage:) forControlEvents:UIControlEventTouchUpInside];
    self.userName.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.userName];
    
    //信息
    self.messageButton = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:@"信封"];
    self.messageButton.tag = ButtonMessage;
    [self.messageButton addTarget:self action:@selector(pushToMessagePage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageButton];
    
    //设置
    self.settingButton = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:@"设置"];
    self.settingButton.tag = ButtonSetting;
    [self.settingButton addTarget:self action:@selector(pushToSettingPage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settingButton];
    
    [self autoLayout];//自动布局
}

- (void)pushToSettingPage:(UIButton *)sender {
    self.buttonClick(sender.tag);
}

- (void)pushToMessagePage:(UIButton *)sender {
    self.buttonClick(sender.tag);
}

- (void)pushToUserInfo:(UIButton *)sender {
    self.buttonClick(sender.tag);
}

- (void)autoLayout {
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_imageHeight, _imageHeight));
        make.left.mas_equalTo(self).with.offset(_imageHeight/4);
        make.bottom.mas_equalTo(self).with.offset(-_imageHeight/4);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).with.offset(_imageHeight/4);
        make.height.mas_equalTo(self.userImageView.mas_height);
        make.centerY.mas_equalTo(self.userImageView);
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(20);
        make.right.mas_equalTo(self.settingButton.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
