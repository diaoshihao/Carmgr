//
//  BalanceView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BalanceView.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation BalanceView
{
    UILabel *balanceLab;
}

- (instancetype)initWithBalance:(CGFloat)balance
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        self.balance = balance;
        [self initViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self initViews];
    }
    return self;
}

- (void)setBalance:(CGFloat)balance {
    _balance = balance;
    balanceLab.text = [NSString stringWithFormat:@"%.2lf",balance];
}

- (void)initViews {
    UIView *balanceView = [self balanceLabel];
    [self addSubview:balanceView];
    [balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    UIButton *payMan = [self buttonWithTitle:@"支付管理"];
    payMan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [payMan setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    payMan.tag = 10;
    [self addSubview:payMan];
    [payMan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(balanceView.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    UIButton *bankCard = [self buttonWithTitle:@"银行卡"];
    bankCard.tag = 11;
    [self addSubview:bankCard];
    [bankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payMan.mas_bottom).offset(60);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    UIButton *withDraw = [self buttonWithTitle:@"提现"];
    withDraw.tag = 12;
    [self addSubview:withDraw];
    [withDraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bankCard.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
}

- (UIView *)balanceLabel {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"您的帐号余额";
    [back addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(back);
    }];
    balanceLab = [[UILabel alloc] init];
    balanceLab.text = [NSString stringWithFormat:@"%.2lf",self.balance ? self.balance : 0.00];
    balanceLab.textAlignment = NSTextAlignmentRight;
    [back addSubview:balanceLab];
    [balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(back);
    }];
    return back;
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick:(UIButton *)sender {
    self.buttonClick(sender.tag - 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
