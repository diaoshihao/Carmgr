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
        [self customView];
    }
    return self;
}

- (void)customView {
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    self.backView = [[UIView alloc] init];
//    self.backView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.backView];
    
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(self);
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
