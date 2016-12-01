//
//  HotCityTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "HotCityTableViewCell.h"
#import "DefineValue.h"

@implementation HotCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotCitys:(NSArray *)hotCitys {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [DefineValue separaColor];
        [self initButtons:hotCitys];
    }
    return self;
}

- (void)initButtons:(NSArray *)citys {
    UIButton *lastButton = nil;
    for (NSInteger i = 0; i < citys.count; i++) {
        UIButton *button = [self buttonForCell:citys[i] frame:CGRectMake(20 + (i % 3) * (kButtonWidth + 20), 10 + (i / 3) * (kButtonHeight + 20), kButtonWidth, kButtonHeight)];
        [self.contentView addSubview:button];
        lastButton = button;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, lastButton.frame.origin.y + kButtonHeight, [DefineValue screenWidth], 44)];
    label.text = @"全部城市";
    label.font = [DefineValue font14];
    [self.contentView addSubview:label];
}

- (void)buttonDidClick:(UIButton *)sender {
    self.clickBlock(sender);
}

- (UIButton *)buttonForCell:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [DefineValue font14];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.hideBlcok();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
