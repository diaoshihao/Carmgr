//
//  CurrentServiceScrollView.m
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CurrentServiceScrollView.h"
#import "CurrentServiceView.h"
#import "CurrentServiceModel.h"
#import <Masonry.h>

@interface CurrentServiceScrollView()

@property (nonatomic, strong) CurrentServiceView *serviceView;

@end

@implementation CurrentServiceScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
        
        //设置superview透明度0，错误做法：self.alpha = 0;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return self;
}

- (instancetype)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.bounces = NO;
        self.alpha = 0;
    }
    return self;
}

- (void)setNearbyServices:(NSArray *)nearbyServices {
    _nearbyServices = nearbyServices;
    [self configCurrentServiceView];
}

- (void)configCurrentServiceView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.contentSize = CGSizeMake(width * self.nearbyServices.count, 0);
    
    for (NSInteger i = 0; i < self.nearbyServices.count; i++) {
        CurrentServiceModel *model = self.nearbyServices[i];
        UIView *contentView = [self contentView:model];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i * width);
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(0);
            //设置右边距
            if (i == self.nearbyServices.count - 1) {
                make.right.mas_equalTo(0);
            }
        }];
    }
}

- (UIView *)contentView:(CurrentServiceModel *)model{
    
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    UIView *leftView = [[UIView alloc] init];
    if (model == self.nearbyServices.firstObject) {
        leftView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    } else {
        leftView.backgroundColor = [UIColor whiteColor];
    }
    [background addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(20);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    if (model == self.nearbyServices.lastObject) {
        rightView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    } else {
        rightView.backgroundColor = [UIColor whiteColor];
    }
    [background addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(20);
    }];
    
    self.serviceView = [[CurrentServiceView alloc] init];
    [self configServiceView:model];
    [background addSubview:self.serviceView];
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(leftView.mas_right).offset(20);
        make.right.mas_equalTo(rightView.mas_left).offset(-20);
    }];
    
    return background;
}

- (void)configServiceView:(CurrentServiceModel *)model {
    self.serviceView.serviceName = model.serviceName;
    self.serviceView.merchantName = model.merchantName;
    self.serviceView.price = model.price;
    [self.serviceView configView];
}

//- (void)didSelectClassOfServices:(CustomSegmentedControl *)segmented {
//    //delegate
//    [self.classifyDelegate didSelectedCurrentService:self.services[segmented.selectedSegmentIndex]];
//    //block
//    self.selectService(self.services[segmented.selectedSegmentIndex]);
//}
//
//- (void)didSelectedCurrentService:(SelectService)seleted {
//    self.selectService = seleted;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
