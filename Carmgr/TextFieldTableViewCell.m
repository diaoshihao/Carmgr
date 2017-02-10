//
//  TextFieldTableViewCell.m
//  Carmgr
//
//  Created by admin on 2017/2/8.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "TextFieldTableViewCell.h"
#import <Masonry.h>

@implementation TextFieldTableViewCell

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
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(20);
    }];
    
    self.describeTextField = [[UITextField alloc] init];
    [self.contentView addSubview:self.describeTextField];
    [self.describeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(0);
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
