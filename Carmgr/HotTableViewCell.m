//
//  HotTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HotTableViewCell.h"
#import <Masonry.h>

@implementation HotTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createViewAtSelf];
    }
    return self;
}

- (void)createViewAtSelf {
    self.hotImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.hotImageView];
    
    [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.height - 20, self.bounds.size.height - 20));
    }];
}

+ (NSString *)getReuseID {
    return @"hottableviewcell";
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
