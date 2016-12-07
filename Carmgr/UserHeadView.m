//
//  UserHeadView.m
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserHeadView.h"
#import "DefineValue.h"
#import "CustomButton.h"
#import <Masonry.h>

@interface UserHeadView()

@property (nonatomic, strong) CustomButton *settingButton;
@property (nonatomic, strong) CustomButton *messageButton;

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
    self.userImageView = [CustomButton cycleImageButton:@"头像"];
    [self addSubview:self.userImageView];
    
    //用户名
    NSString *username = @"登录/注册";
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    }
    self.userName = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionDefault];
    [self.userName setTitle:username forState:UIControlStateNormal];
    [self.userName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.userName.tag = ButtonUserName;
    [self.userName addTarget:self action:@selector(pushToMessagePage:) forControlEvents:UIControlEventTouchUpInside];
    self.userName.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.userName];
    
    //信息
    self.messageButton = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionDefault];
    [self.messageButton setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    self.messageButton.tag = ButtonMessage;
    [self.messageButton addTarget:self action:@selector(pushToMessagePage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageButton];
    
    //设置
    self.settingButton = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionDefault];
    [self.settingButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    self.settingButton.tag = ButtonSetting;
    [self.settingButton addTarget:self action:@selector(pushToSettingPage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settingButton];
    
    [self autoLayout];//自动布局
}

- (void)pushToSettingPage:(CustomButton *)sender {
    self.buttonClick(sender.tag);
}

- (void)pushToMessagePage:(CustomButton *)sender {
    self.buttonClick(sender.tag);
}

- (void)pushToUserInfo:(CustomButton *)sender {
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
