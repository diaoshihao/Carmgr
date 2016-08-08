//
//  AddCarInfoCell.m
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AddCarInfoCell.h"
#import <Masonry.h>

@implementation AddCarInfoCell

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

- (void)customView {
    
    [self.contentView addSubview:self.cusView];
    [self.cusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(20);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

+ (NSString *)getReuseID {
    return @"addcarinfocell";
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
