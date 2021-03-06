//
//  ServiceCollectionCell.m
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceCollectionCell.h"
#import <Masonry.h>

@implementation ServiceCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageView:frame.size.width];
    }
    return self;
}

- (UIImageView *)createImageView:(CGFloat)width {
    
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(0);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width-10, width-10));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(0);
    }];
    return self.imageView;
}

+ (NSString *)getCellID {
    return @"servicecollectioncell";
}


@end
