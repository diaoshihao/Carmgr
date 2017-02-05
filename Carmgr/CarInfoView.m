//
//  CarInfoView.m
//  Carmgr
//
//  Created by admin on 2017/1/12.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CarInfoView.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "AlertShowAssistant.h"

@implementation InfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView {
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.mas_equalTo(self);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [DefineValue buttonColor];
    self.titleLabel.font = [DefineValue font16];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
    }];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = [DefineValue fieldColor];
    self.textLabel.font = [DefineValue font14];
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
}

@end

@implementation CarInfoView

- (instancetype)initWithInfo:(NSArray *)infoArr
{
    self = [super init];
    if (self) {
        self.infoArr = infoArr;
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
    
//    UIButton *addNewCar = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addNewCar setImage:[UIImage imageNamed:@"新添车辆"] forState:UIControlStateNormal];
//    [background addSubview:addNewCar];
//    [addNewCar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-16);
//        make.centerY.mas_equalTo(background);
//    }];
    
    UIButton *deleteCar = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteCar setImage:[UIImage imageNamed:@"删除车辆"] forState:UIControlStateNormal];
    [deleteCar addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:deleteCar];
    [deleteCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
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

- (void)deleteAction {
    [AlertShowAssistant alertTip:@"提示" message:@"是否删除当前车辆" actionTitle:@"删除" defaultHandle:^{
        if (self.deleteCarBlock) {
            self.deleteCarBlock();
        }
    } cancelHandle:^{
        
    }];
}

- (void)deleteCarAction:(DeleteCarBlock)deleteCarBlock {
    self.deleteCarBlock = deleteCarBlock;
}

- (void)configView {
    UIView *myCarView = [self myCarView];
    [self addSubview:myCarView];
    [myCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    NSArray *titles = @[@"车辆品牌",@"车牌号码",@"发动机号",@"车架号码"];
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSInteger i = 0; i < titles.count; i++) {
        InfoView *infoView = [[InfoView alloc] init];
        infoView.titleLabel.text = titles[i];
        
        NSString *text = self.infoArr[i];
        if (i >= 2) {
            text = [NSString stringWithFormat:@"%@%@",@"*",self.infoArr[i]];
        }
        infoView.textLabel.text = text;
        [self addSubview:infoView];
        [views addObject:infoView];
    }
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myCarView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
}


@end
