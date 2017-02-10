//
//  ForHelpTableViewCell.m
//  Carmgr
//
//  Created by admin on 2017/2/8.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "TextViewTableViewCell.h"
#import <Masonry.h>

@implementation TextViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}

- (void)configViews {
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
    }];
    
    self.describeTextView = [[CustomTextView alloc] init];
    [self.contentView addSubview:self.describeTextView];
    [self.describeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(85);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-10);
    }];
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
