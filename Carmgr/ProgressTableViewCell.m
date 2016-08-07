//
//  ProgressTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ProgressTableViewCell.h"
#import <Masonry.h>

@implementation ProgressTableViewCell

+ (NSString *)getReuseID {
    return @"progresscell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //商店名
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.storeName];
        
        //服务名
        self.serviceLabel = [[UILabel alloc] init];
        self.serviceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.serviceLabel];
        
        //头像
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.headImageView];
        
        //订单号
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.numberLabel];
        
        //时间
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
        
        //服务状态
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.stateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.stateLabel];
        
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
        self.button1.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.button1];
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
        self.button2.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.button2];
        
        [self autoLayout];

    }
    return self;
}

- (void)autoLayout {
    [self.storeName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.storeName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(10);
        make.left.mas_equalTo(self.contentView).with.offset(20);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.storeName.mas_bottom).with.offset(3);
        make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.contentView).with.offset(-10);
        make.width.mas_equalTo(self.headImageView.mas_height).multipliedBy(93.0/85);
    }];
    
    [self.serviceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.serviceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_top).with.offset(2);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(10);
    }];
    
    [self.numberLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.numberLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceLabel.mas_left).with.offset(0);
        make.centerY.mas_equalTo(self.headImageView);
    }];
    
    [self.timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceLabel.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom).with.offset(-3);
    }];
    
    [self.stateLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.stateLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.storeName);
    }];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.serviceLabel);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(self.storeName);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.timeLabel);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(self.storeName);
    }];
    
}

@end
