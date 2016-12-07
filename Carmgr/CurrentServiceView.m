//
//  CurrentServiceView.m
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CurrentServiceView.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation CurrentServiceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configView {
    UILabel *serviceLab = [[UILabel alloc] init];
    serviceLab.text = self.serviceName;
    [self addSubview:serviceLab];
    [serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *merchantLab = [[UILabel alloc] init];
    merchantLab.text = self.merchantName;
    merchantLab.font = [DefineValue font14];
    merchantLab.textColor = [DefineValue fieldColor];
    [self addSubview:merchantLab];
    [merchantLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(serviceLab.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.text = [NSString stringWithFormat:@"%@ 元／单",self.price];
    priceLab.textColor = [DefineValue mainColor];
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(merchantLab.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-20);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
