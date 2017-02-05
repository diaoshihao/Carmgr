//
//  MyCarView.m
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MyCarView.h"
#import "AddCarView.h"
#import "CarInfoView.h"
#import <Masonry.h>

@implementation MyCarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addCarView];
    }
    return self;
}

- (void)setHasCar:(BOOL)hasCar {
    if (hasCar) {
        [self carInfoView];
    } else {
        [self addCarView];
    }
}


- (void)beginMyCarAction:(MyCarBlock)myCarBlock {
    self.myCarBlock = myCarBlock;
}

//添加车辆view
- (void)addCarView {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    AddCarView *addCarView = [[AddCarView alloc] init];
    [addCarView beginAddCarInfo:^{
        if (self.myCarBlock) {
            self.myCarBlock(MyCarActionAddInfo);
        }
    }];
    [self addSubview:addCarView];
    [addCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

//有车辆信息的view
- (void)carInfoView {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *infoArr = @[self.infoModel.vehicle_brand,self.infoModel.vehicle_number,self.infoModel.engine_number,self.infoModel.frame_number];
    CarInfoView *carInfoView = [[CarInfoView alloc] initWithInfo:infoArr];
    [carInfoView deleteCarAction:^{
        self.hasCar = NO;
    }];
    [self addSubview:carInfoView];
    [carInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
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
