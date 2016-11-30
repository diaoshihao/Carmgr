//
//  ProgressTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ProgressTableViewCell.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation ProgressTableViewCell
{
    MyOrderView *_orderView;
}

+ (NSString *)getReuseID {
    return @"progresscell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _orderView = [[MyOrderView alloc] init];
        
        [self configViews];
    }
    return self;
}

- (void)OrderState:(OrderProgress)progress {
    self.stateLabel.text = _orderView.progressView.titles[progress];
}

- (UIView *)serviceDetailView {
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [DefineValue separaColor];
    
    //头像
    self.headImageView = [[UIImageView alloc] init];
    [background addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.headImageView.mas_height).multipliedBy(93.0/85);
    }];
    
    //服务名
    self.serviceLabel = [[UILabel alloc] init];
    self.serviceLabel.font = [UIFont systemFontOfSize:14];
    [background addSubview:self.serviceLabel];
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_top);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(8);
    }];
    
    //订单号
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = [UIFont systemFontOfSize:12];
    [background addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceLabel.mas_left).with.offset(0);
        make.centerY.mas_equalTo(self.headImageView);
    }];
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [background addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceLabel.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
    }];
    
    return background;
}

- (void)configViews {
    //商店名
    self.storeName = [[UILabel alloc] init];
    self.storeName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.storeName];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.contentView).with.offset(20);
        make.height.mas_equalTo(44);
    }];
    
    //服务状态
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    self.stateLabel.textColor = [DefineValue mainColor];
    [self.contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.storeName);
    }];
    
    UIView *servicesView = [self serviceDetailView];
    [self.contentView addSubview:servicesView];
    [servicesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.storeName.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(88);
    }];
    
    self.costLabel = [[UILabel alloc] init];
    self.costLabel.font = [DefineValue font14];
    [self.contentView addSubview:self.costLabel];
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(servicesView.mas_bottom).offset(10);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
    
//    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-20);
//        make.centerY.mas_equalTo(self.serviceLabel);
//        make.width.mas_equalTo(70);
//        make.height.mas_equalTo(self.storeName);
//    }];
//    
//    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-20);
//        make.centerY.mas_equalTo(self.timeLabel);
//        make.width.mas_equalTo(70);
//        make.height.mas_equalTo(self.storeName);
//        make.bottom.mas_equalTo(-10);
//    }];
    
}

@end
