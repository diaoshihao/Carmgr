//
//  ForHelpView.m
//  Carmgr
//
//  Created by admin on 2017/2/7.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "ForHelpView.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation ForHelpView
{
    UIButton *_help;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.86];
    
    [self configHelpButton];
    [self configBackButton];
}

- (void)configHelpButton {
    CGFloat radius = [UIScreen mainScreen].bounds.size.width / 5;
    _help = [UIButton buttonWithType:UIButtonTypeCustom];
    [_help setImage:[UIImage imageNamed:@"发布求助"] forState:UIControlStateNormal];
    [_help setBackgroundColor:[DefineValue mainColor]];
    _help.layer.cornerRadius = radius / 2;
    _help.layer.masksToBounds = YES;
    [_help addTarget:self action:@selector(forHelp) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_help];
    
    [_help mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-150);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(radius, radius));
    }];
    
    UILabel *helpLabel = [[UILabel alloc] init];
    helpLabel.text = @"发布求助";
    helpLabel.textColor = [UIColor whiteColor];
    helpLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:helpLabel];
    [helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_help);
        make.top.mas_equalTo(_help.mas_bottom).offset(5);
    }];
}

- (void)forHelp {
    if (self.helpBlock) {
        self.helpBlock();
    }
}

- (void)needForHelp:(HelpBlock)helpBlock {
    self.helpBlock = helpBlock;
}

- (void)configBackButton {
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)back {
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
