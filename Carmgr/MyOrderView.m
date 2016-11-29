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
#import "UpperImageButton.h"

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
    
    NSArray *titles = @[@"全部",@"待付款",@"待使用",@"进行中",@"已完成",@"待评价",@"售后"];
    NSArray *images = @[@"全部",@"待付款",@"待使用",@"进行中",@"已完成",@"待评价",@"售后"];
    NSMutableArray *buttons = [NSMutableArray new];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UpperImageButton buttonWithType:UIButtonTypeCustom];
        button.tag = OrderProgressAll + i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
        button.titleLabel.font = [DefineValue font14];
        [button addTarget:self action:@selector(progressAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [buttons addObject:button];
    }
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:[DefineValue screenWidth] / 7 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(separator.mas_bottom);
        make.height.mas_equalTo(64);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)progressAction:(UIButton *)sender {
    self.progress(sender.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
