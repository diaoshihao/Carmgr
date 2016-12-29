//
//  RateTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "RateTableViewCell.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation RateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configView];
        [self layoutView];
        
    }
    return self;
}

- (void)setStars:(NSString *)stars {
    _stars = stars;
    self.starsView.stars = stars;
}

- (void)configView {
    //头像
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    
    //用户名
    self.userNameLab = [[UILabel alloc] init];
    self.userNameLab.font = [DefineValue font14];
    self.userNameLab.textColor = [DefineValue rgbColor51];
    [self.contentView addSubview:self.userNameLab];
    
    //时间
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:11];
    self.timeLab.textColor = [DefineValue rgbColor102];
    [self.contentView addSubview:self.timeLab];
    
    //星级
    self.starsView = [[StarsView alloc] init];
    [self.contentView addSubview:self.starsView];
    
    //内容
    self.rateLab = [[CustomLabel alloc] init];
    self.rateLab.numberOfLines = 0;
    self.rateLab.lineSpace = 10;
    self.rateLab.textColor = [UIColor blackColor];
    self.rateLab.font = [DefineValue font12];
    [self.contentView addSubview:self.rateLab];
}

- (void)layoutView {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_top);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(18);
    }];
    
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameLab.mas_bottom);
        make.left.mas_equalTo(self.userNameLab.mas_left);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
        
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.starsView.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.starsView);
    }];
    
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
}

+ (NSString *)getReuseID {
    return @"ratetableviewcell";
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
