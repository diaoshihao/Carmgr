//
//  CurrentServiceCollectionViewCell.m
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CurrentServiceCollectionViewCell.h"
#import <Masonry.h>

@implementation CurrentServiceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCollectionSubviews];
    }
    return self;
}

- (void)layoutCollectionSubviews {
    UILabel *serviceLab = [[UILabel alloc] init];
    serviceLab.text = self.serviceName;
    [self addSubview:serviceLab];
    [serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *merchantLab = [[UILabel alloc] init];
    merchantLab.text = self.merchantName;
    [self addSubview:merchantLab];
    [merchantLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(serviceLab.mas_bottom).offset(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.text = [NSString stringWithFormat:@"%@ 元／单",self.merchantName];
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(merchantLab.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}


@end
