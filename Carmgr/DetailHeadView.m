//
//  DetailHeadView.m
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DetailHeadView.h"
#import <Masonry.h>
#import "StarsView.h"
#import "DefineValue.h"
#import <UIImageView+WebCache.h>

@interface DetailHeadView()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *merchant_nameLab;

@property (nonatomic, strong) StarsView *starsView;

@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) UIButton *addressBtn;

@end

@implementation DetailHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configView];
        [self layoutView];
    }
    return self;
}

- (void)setStars:(NSString *)stars {
    _stars = stars;
    self.starsView.stars = stars;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    [self.addressBtn setTitle:address forState:UIControlStateNormal];
}

- (void)setImg_path:(NSString *)img_path {
    _img_path = img_path;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:img_path] placeholderImage:nil];
}

- (void)setMerchant_name:(NSString *)merchant_name {
    _merchant_name = merchant_name;
    self.merchant_nameLab.text = merchant_name;
}


- (void)configView {
    [self configHeadImageView];
    [self configMerchant_nameLabel];
    [self configStarsView:self.stars];
    [self configPayButton];
    [self configAddressButton];
}

- (void)layoutView {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 300 / 720);
    }];
    
    [self.merchant_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
    }];
    
    [self.starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.merchant_nameLab.mas_bottom);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(self.payButton.mas_bottom);
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(20);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.starsView.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo([DefineValue screenWidth]);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

- (void)configHeadImageView {
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.headImageView];
}

- (void)configMerchant_nameLabel {
    self.merchant_nameLab = [[UILabel alloc] init];
    [self addSubview:self.merchant_nameLab];
}

- (void)configPayButton {
    self.payButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.payButton setTitle:@"费用支付" forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payButton.enabled = NO;
    self.payButton.hidden = YES;
    [self.payButton setBackgroundColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0]];
    [self addSubview:self.payButton];
}

- (void)configStarsView:(NSString *)stars {
    self.starsView = [[StarsView alloc] init];
    self.starsView.bigStar = YES;
    [self addSubview:self.starsView];
}

- (void)configAddressButton {
    self.addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addressBtn setTitleColor:[UIColor colorWithRed:102.0/256.0 green:102.0/256.0 blue:102.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.addressBtn setBackgroundColor:[UIColor whiteColor]];
    [self.addressBtn setImage:[UIImage imageNamed:@"定位-1"] forState:UIControlStateNormal];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], [DefineValue pixHeight] * 2)];
    separator.backgroundColor = [DefineValue separaColor];
    [self.addressBtn addSubview:separator];
    
    [self.addressBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.addressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [self.addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, self.addressBtn.imageView.frame.size.width + 8, 0, 0)];
    
    [self addSubview:self.addressBtn];
    
}


@end
