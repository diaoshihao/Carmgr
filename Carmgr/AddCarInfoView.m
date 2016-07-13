//
//  AddCarInfoView.m
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AddCarInfoView.h"
#import <Masonry.h>

@interface AddCarInfoView () <UITextFieldDelegate>

@end

@implementation AddCarInfoView

- (UILabel *)labelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

- (NSArray *)textFieldArray:(NSInteger)forSection {
    NSArray *placeholder = @[@[@"请输入车牌号",@"请输入后4位发动机号",@"请输入后6位车架号"],@[@"请输入保险进保日期",@"请输入首次保养日期",@"请输入行驶公里数"]];
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 3; i++) {
        UITextField *textField = [self textFieldWithPlaceholder:placeholder[forSection-2][i]];
        if (forSection == 2 && i == 0) {
            UILabel *label = [self labelWithTitle:@"粤"];
            label.frame = CGRectMake(0, 0, 30, 35);
            label.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            textField.leftView = label;
        }
        [arrM addObject:textField];
    }
    return arrM;
    
}

- (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:15];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.superView endEditing:YES];
    return YES;
}

//查询按钮
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
    segmentCtrl.tintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    [segmentCtrl setSelectedSegmentIndex:0];
    return segmentCtrl;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
