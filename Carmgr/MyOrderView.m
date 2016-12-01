//
//  MyOrderView.m
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MyOrderView.h"
#import <Masonry.h>
#import "DefineValue.h"

@interface MyProgressView()

@property (nonatomic, strong) NSArray *buttons;

@end

@implementation MyProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self progressView];
    }
    return self;
}

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"全部",@"待付款",@"待使用",@"进行中",@"已完成",@"待评价",@"售后"];
    }
    return _titles;
}

- (NSArray *)images {
    if (_images == nil) {
        _images = @[@"全部",@"待付款",@"待使用",@"进行中",@"已完成",@"待评价",@"售后"];
    }
    return _images;
}

- (NSArray *)selectedImages {
    if (_selectedImages == nil) {
        _selectedImages = @[@"全部橙",@"待付款橙",@"待使用橙",@"进行中橙",@"已完成橙",@"待评价橙",@"售后橙"];
    }
    return _selectedImages;
}

- (void)progressView {
    
    NSMutableArray *buttons = [NSMutableArray new];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionUpper];
        button.tag = OrderProgressAll + i + 10;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selectedImages[i]] forState:UIControlStateSelected];
        [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
        [button setTitleColor:[DefineValue mainColor] forState:UIControlStateSelected];
        button.titleLabel.font = [DefineValue font14];
        [button addTarget:self action:@selector(progressAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [buttons addObject:button];
    }
    self.buttons = buttons;
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:[DefineValue screenWidth] / 7 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


- (void)progressAction:(UIButton *)sender {
    self.progress(sender.tag - 10);
}

- (void)currentOrderState:(OrderProgress)progress {
    for (CustomButton *button in self.buttons) {
        button.selected = NO;
    }
    self.currentSelected = [self viewWithTag:progress + 10];
    self.currentSelected.selected = YES;
}

@end

@interface MyOrderView()

@end

@implementation MyOrderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configView];
    }
    return self;
}

- (UIView *)myOrderView {
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
    myCar.text = @"我的订单";
    [background addSubview:myCar];
    [myCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageVeiw.mas_right).offset(12);
        make.centerY.mas_equalTo(background);
    }];
    return background;
}

- (void)configView {
    UIView *myOrderView = [self myOrderView];
    [self addSubview:myOrderView];
    [myOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [DefineValue separaColor];
    [self addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myOrderView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue pixHeight]);
    }];
    
    self.progressView = [[MyProgressView alloc] init];
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(separator.mas_bottom);
        make.height.mas_equalTo(64);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
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
