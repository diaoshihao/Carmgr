//
//  DetailServiceCell.m
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DetailServiceCell.h"
#import <Masonry.h>

@implementation DetailServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configViews];
        [self layoutViews];
    }
    return self;
}

- (void)setStars:(NSString *)stars {
    _stars = stars;
    self.starsView.stars = stars;
}

- (void)configViews {
    //头像
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    
    //商店名
    self.serviceName = [[UILabel alloc] init];
    self.serviceName.font = [UIFont systemFontOfSize:14];
    self.serviceName.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [self.contentView addSubview:self.serviceName];
    
    //商家介绍
    self.introduce = [[UILabel alloc] init];
    self.introduce.numberOfLines = 1;
    self.introduce.font = [UIFont systemFontOfSize:12];
    self.introduce.textColor = [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
    [self.contentView addSubview:self.introduce];
    
    UIColor *color = [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
    
    self.starsView = [[StarsView alloc] init];
    [self.contentView addSubview:self.starsView];
    
    //地区
    self.area = [[UILabel alloc] init];
    self.area.font = [UIFont systemFontOfSize:11];
    self.area.textColor = color;
    [self.contentView addSubview:self.area];
    
    //街道
    self.road = [[UILabel alloc] init];
    self.road.font = [UIFont systemFontOfSize:11];
    self.road.textColor = color;
    [self.contentView addSubview:self.road];
    
    //距离
    self.distance = [[UILabel alloc] init];
    self.distance.font = [UIFont systemFontOfSize:11];
    self.distance.textColor = color;
    [self.contentView addSubview:self.distance];
}

- (void)layoutViews {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.headImageView.mas_height).multipliedBy(1.382);
    }];
    
    [self.serviceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(10);
    }];
    
    [self.introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceName.mas_left);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.serviceName.mas_bottom).with.offset(8);
    }];
    
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introduce.mas_bottom).offset(8);
        make.left.mas_equalTo(self.serviceName.mas_left);
    }];
    
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceName.mas_left);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.road mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.area.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.area);
    }];
    
    [self.distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.area);
    }];

}

+ (NSString *)getReuseID {
    return @"detailservicecell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
