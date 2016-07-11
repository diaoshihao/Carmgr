//
//  AddCarInfoView.m
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AddCarInfoView.h"
#import <Masonry.h>

@implementation AddCarInfoView

- (UIButton *)createLabelAndButton:(UIView *)broview {
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"我们将爱车信息进行保密，请您放心填写。";
    tipsLabel.font = [UIFont systemFontOfSize:14];
    [self.superView addSubview:tipsLabel];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"开始查询" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [button addTarget:self.target action:@selector(checkCarInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.superView addSubview:button];
    
    
    [tipsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.centerX.mas_equalTo(self.superView);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tipsLabel.mas_top).with.offset(-10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(35);
    }];
    return button;
}

- (void)checkCarInfo {
    
}

- (UISegmentedControl *)numberType {
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"小型汽车",@"大型汽车"]];
//    [segmentCtrl setTitle:@"小型汽车" forSegmentAtIndex:0];
//    [segmentCtrl setTitle:@"大型汽车" forSegmentAtIndex:1];
    [segmentCtrl setSelectedSegmentIndex:0];
    return segmentCtrl;
}

- (UIView *)labelWithTitle:(NSString *)title size:(CGSize)size {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    [view addSubview:label];
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
