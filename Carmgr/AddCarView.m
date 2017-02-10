//
//  AddCarView.m
//  Carmgr
//
//  Created by admin on 2017/1/11.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "AddCarView.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation AddCarView

- (instancetype)init {
    if (self = [super init]) {
        [self configView];
    }
    return self;
}

- (UIView *)myCarView {
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageVeiw = [[UIImageView alloc] init];
    imageVeiw.image = [UIImage imageNamed:@"蓝色"];
    [background addSubview:imageVeiw];
    [imageVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(background);
    }];
    
    UILabel *myCar = [[UILabel alloc] init];
    myCar.text = @"我的车辆";
    [background addSubview:myCar];
    [myCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageVeiw.mas_right).offset(12);
        make.centerY.mas_equalTo(background);
    }];
    
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [DefineValue separaColor];
    [background addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(background.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue pixHeight] * 2);
    }];
    return background;
}

- (void)configView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageHeight = width / 4.5;
    
    UIView *myCarView = [self myCarView];
    [self addSubview:myCarView];
    [myCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"车辆按钮"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addCarInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"点击添加车辆";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [DefineValue rgbColor102];
    [self addSubview:titleLabel];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"添加后能时刻把握爱车信息哦！";
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [DefineValue rgbColor51];
    [self addSubview:tipsLabel];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(myCarView.mas_bottom).offset(imageHeight/4);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(button.mas_bottom).with.offset(20);
    }];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-imageHeight/4);
    }];
}


- (void)addCarInfoAction {
    if (self.addCarInfo) {
        self.addCarInfo();
    }
}

- (void)beginAddCarInfo:(AddCarInfoBlock)addCarInfo {
    self.addCarInfo = addCarInfo;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
