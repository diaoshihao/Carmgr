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
        [self configView];
    }
    return self;
}

- (void)configView {
    self.serviceName = [[UILabel alloc] init];
    [self addSubview:self.serviceName];
    [self.serviceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.merchantName = [[UILabel alloc] init];
    self.merchantName.font = [DefineValue font14];
    self.merchantName.textColor = [DefineValue fieldColor];
    [self addSubview:self.merchantName];
    [self.merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.serviceName.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.price = [[UILabel alloc] init];
    self.price.textColor = [DefineValue mainColor];
    [self addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.merchantName.mas_bottom).offset(10);
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
