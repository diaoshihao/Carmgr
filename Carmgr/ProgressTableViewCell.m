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
        
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.storeName];
        
        self.serviceLabel = [[UILabel alloc] init];
        self.serviceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.serviceLabel];
        
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.headImageView];
        
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.numberLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
        
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
        make.width.mas_equalTo(self.headImageView.mas_height);
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
    
}

@end
