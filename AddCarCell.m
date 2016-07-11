//
//  AddCarCell.m
//  Carmgr
//
//  Created by admin on 16/7/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AddCarCell.h"
#import <Masonry.h>

@implementation AddCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.userInteractionEnabled = YES;
        [self customView];
    }
    return self;
}

- (void)customView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageHeight = width / 4.5;
    
    self.button = [[UIButton alloc] init];
    [self.button setBackgroundImage:[UIImage imageNamed:@"车辆按钮"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.button];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"点击添加车辆";
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:titleLabel];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"添加后能时刻把握爱车信息哦！";
    tipsLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:tipsLabel];
    
    [self.button setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.button setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(imageHeight/4);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    
    [titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.button.mas_bottom).with.offset(imageHeight/4);
    }];
    
    [tipsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(-imageHeight/4);
    }];
}

@end
