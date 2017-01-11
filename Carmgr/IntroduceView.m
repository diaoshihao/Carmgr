//
//  IntroduceView.m
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "IntroduceView.h"
#import "DefineValue.h"
#import <Masonry.h>
#import "CustomLabel.h"

@interface IntroduceView()

@property (nonatomic, strong) CustomLabel *introduceLab;

@end

@implementation IntroduceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self configView];
    }
    return self;
}

- (void)setIntroduce:(NSString *)introduce {
    _introduce = introduce;
    if (introduce == nil) {
        _introduce = @"";
    }
    self.introduceLab.text = _introduce;
}

- (void)configView {
    UILabel *titleLabel = [self titleLabel];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.introduceLab = [[CustomLabel alloc] init];
    self.introduceLab.numberOfLines = 3;
    self.introduceLab.lineSpace = 10;
    self.introduceLab.font = [DefineValue font12];
    self.introduceLab.textColor = [DefineValue rgbColor51];
    [self addSubview:self.introduceLab];
    [self.introduceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset([DefineValue pixHeight] * 2);
        make.left.and.right.mas_equalTo(0);
    }];
    
    CustomButton *lookMore = [self moreButton];
    [lookMore addTarget:self action:@selector(lookMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lookMore];
    [lookMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introduceLab.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"商家详情";
    label.font = [DefineValue font14];
    label.textColor = [DefineValue mainColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (CustomButton *)moreButton {
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionRight];
    button.backgroundColor = [UIColor whiteColor];
    button.normalTitle = @"查看更多";
    button.selectedTitle = @"收起更多";
    button.titleLabel.font = [DefineValue font12];
    button.normalColor = [DefineValue rgbColor102];
    button.normalImageName = @"下拉黑";
    button.selectedImageName = @"上拉黑";
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], [DefineValue pixHeight] * 2)];
    separator.backgroundColor = [DefineValue separaColor];
    [button addSubview:separator];

    return button;
}

- (void)lookMoreAction:(CustomButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.introduceLab.numberOfLines = 0;
    } else {
        self.introduceLab.numberOfLines = 3;
    }
}



@end
