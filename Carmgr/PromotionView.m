//
//  Promotion.m
//  Carmgr
//
//  Created by admin on 2016/11/25.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "PromotionView.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "YWPublic.h"

@implementation PromotionView
{
    UIButton *_leftBtn;
    UIButton *_rightTopBtn;
    UIButton *_rightBottomBtn;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self configView];
    }
    return self;
}

- (UIButton *)configButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)click:(UIButton *)sender {
    self.click(sender.tag - 10);
}

- (void)setImageFor:(ButtonPosition)position imageUrl:(NSString *)imageUrl {
    if (![imageUrl hasPrefix:@"http"]) { //不是图片网址，返回
        return;
    }
    UIButton *button = (UIButton *)[self viewWithTag:position + 10];
    [YWPublic loadWebImage:imageUrl didLoad:^(UIImage * _Nonnull image) {
        [button setImage:image forState:UIControlStateNormal];
    }];
}

- (void)configView {
    _leftBtn = [self configButton];
    _leftBtn.tag = ButtonPositionLeft + 10;
    [self addSubview:_leftBtn];
    _rightTopBtn = [self configButton];
    _rightTopBtn.tag = ButtonPositionRightTop + 10;;
    [self addSubview:_rightTopBtn];
    _rightBottomBtn = [self configButton];
    _rightBottomBtn.tag = ButtonPositionRightBottom + 10;;
    [self addSubview:_rightBottomBtn];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo([DefineValue screenWidth] / 2 - [DefineValue pixHeight]);
    }];
    [_rightTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(_leftBtn.mas_height).multipliedBy(0.5);
        make.left.mas_equalTo(_leftBtn.mas_right).offset([DefineValue pixHeight] * 2);
    }];
    [_rightBottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_rightTopBtn.mas_bottom).offset([DefineValue pixHeight] * 2);
        make.left.mas_equalTo(_rightTopBtn.mas_left);
        make.bottom.and.right.mas_equalTo(0);
    }];
}

@end


@implementation DiscountView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self configView];
    }
    return self;
}

- (void)click:(UIButton *)sender {
    self.click(sender.tag - 20);
}

- (void)setDiscountImages:(NSArray *)images {
    for (NSInteger i = 0; i < images.count; i++) {
        [self setImageFor:i + 1 imageUrl:images[i]];
    }
}

- (void)setImageFor:(ButtonPosition)position imageUrl:(NSString *)imageUrl {
    if (![imageUrl hasPrefix:@"http"]) { //不是图片网址，返回
        return;
    }
    UIButton *button = (UIButton *)[self viewWithTag:position + 20];
    [YWPublic loadWebImage:imageUrl didLoad:^(UIImage * _Nonnull image) {
        [button setImage:image forState:UIControlStateNormal];
    }];
}

- (UIButton *)configButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)configView {
    UIButton *leftTop = [self configButton];
    leftTop.tag = ButtonPositionLeftTop + 20;
    [self addSubview:leftTop];
    UIButton *leftMiddle = [self configButton];
    leftMiddle.tag = ButtonPositionLeftMiddle + 20;
    [self addSubview:leftMiddle];
    UIButton *leftBottom = [self configButton];
    leftBottom.tag = ButtonPositionLeftBottom + 20;
    [self addSubview:leftBottom];
    
    UIButton *rightTop = [self configButton];
    rightTop.tag = ButtonPositionRightTop + 20;
    [self addSubview:rightTop];
    UIButton *rightMiddle = [self configButton];
    rightMiddle.tag = ButtonPositionRightMiddle + 20;
    [self addSubview:rightMiddle];
    UIButton *rightBottom = [self configButton];
    rightBottom.tag = ButtonPositionRightBottom + 20;
    [self addSubview:rightBottom];
    
    NSArray *leftButtons = @[leftTop,leftMiddle,leftBottom];
    NSArray *rightButtons = @[rightTop,rightMiddle,rightBottom];
    
    [leftButtons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:[DefineValue pixHeight] * 2 leadSpacing:0 tailSpacing:0];
    [leftButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo([DefineValue screenWidth] / 2 - [DefineValue pixHeight]);
    }];
    
    [rightButtons mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:[DefineValue pixHeight] * 2 leadSpacing:0 tailSpacing:0];
    [rightButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo([DefineValue screenWidth] / 2 - [DefineValue pixHeight]);
    }];
}

@end
