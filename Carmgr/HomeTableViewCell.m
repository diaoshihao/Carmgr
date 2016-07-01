//
//  HomeTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeView.h"

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backView = [[UIView alloc] initWithFrame:self.frame];
        [self.contentView addSubview:self.backView];
    }
    return self;
}

+ (NSString *)reuseID {
    return @"hometableviewcell";
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
