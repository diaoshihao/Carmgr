//
//  UserInfoCell.m
//  Carmgr
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserInfoCell.h"
#import <Masonry.h>

@implementation UserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self);
        }];
        
    }
    return self;
}

- (void)customViewAtRow:(NSInteger)row {
    if (row == 0) {
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentView);
        }];
    } else {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.center.mas_equalTo(self.contentView);
        }];
    }
    
}

+ (NSString *)getReuseID {
    return @"userinfocell";
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
