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
    __weak typeof(self) weakSelf = self;
    
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).with.offset(0);
        make.left.mas_equalTo(weakSelf).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).with.offset(5);
        make.left.mas_equalTo(weakSelf).with.offset(0);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(0);
    }];
    return self.imageView;
}



+ (NSString *)getCellID {
    return @"servicecollectioncell";
}


@end
