//
//  RegistView.m
//  Carmgr
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "RegistView.h"
#import <Masonry.h>
#import "YWPublic.h"

@implementation RegistView

//创建三个根据步骤改变颜色的view
- (UIView *)createSelectViewAtSuperView:(UIView *)superView registStep:(RegistStep)step {
    UIView *backView = [[UIView alloc] init];
    [superView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView).with.offset(65);
        make.left.mas_equalTo(superView).with.offset(0);
        make.right.mas_equalTo(superView).with.offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    UIView *view = [[UIView alloc] init];
    [backView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView).with.offset(65);
        make.left.mas_equalTo(superView).with.offset(0);
        make.right.mas_equalTo(superView).with.offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width) / 3;
    NSArray *titleArr = @[@"输入手机号",@"输入验证码",@"设置密码"];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIView *stepView = nil;
        if (step == i) {
            stepView = [self creatViewWithTitle:titleArr[i] selected:YES];
        } else {
            stepView = [self creatViewWithTitle:titleArr[i] selected:NO];
        }
        [view addSubview:stepView];
        
        [stepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view).with.offset(0);
            make.left.mas_equalTo(view).with.offset(i * width);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(view);
        }];
    }
    return view;
}

//根据步骤改变颜色的view
- (UIView *)creatViewWithTitle:(NSString *)title selected:(BOOL)selected {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width)/3, 35)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = font;
    [view addSubview:label];
    CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(labelSize);
        make.left.mas_equalTo(view).with.offset(15);
        make.centerY.mas_equalTo(view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(label);
        make.left.mas_equalTo(label.mas_right).with.offset(1);
        make.centerY.mas_equalTo(view);
    }];
    
    if (selected) {
        label.textColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
        imageView.image = [UIImage imageNamed:@"前进"];
    } else {
        imageView.image = [UIImage imageNamed:@"前进1"];
    }
    return view;
}

//输入框
- (UITextField *)createTextFieldAtSuperView:(UIView *)superView broView:(UIView *)broView placeholder:(NSString *)placeholder {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UITextField *textField = [YWPublic createTextFieldWithFrame:CGRectZero placeholder:placeholder isSecure:NO];
    textField.font = font;
    [superView addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(superView).with.offset(0);
        make.right.mas_equalTo(superView).with.offset(0);
        make.height.mas_equalTo(35);
    }];
    
    return textField;
}

//按钮
- (UIButton *)createButtonAtSuperView:(UIView *)superView Constraints:(UIView *)broView title:(NSString *)title target:(UIViewController *)target action:(SEL)selector {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:title imageName:nil];
    button.titleLabel.font = font;
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(superView).with.offset(15);
        make.right.mas_equalTo(superView).with.offset(-15);
        make.height.mas_equalTo(broView.mas_height);
    }];
    return button;
}

- (UILabel *)createInfoLabelAtSuperView:(UIView *)superView phoneNum:(NSString *)phoneNum broview:(UIView *)broview {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIView *view = [[UIView alloc] init];
    [superView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broview.mas_bottom).with.offset(0);
        make.left.mas_equalTo(superView).with.offset(0);
        make.right.mas_equalTo(superView).with.offset(0);
        make.height.mas_equalTo(35);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"验证码短信已发送到%@",phoneNum];
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(superView).with.offset(0);
        make.right.mas_equalTo(superView).with.offset(0);
    }];
    return label;
}

- (void)createAgreementViewAtSuperView:(UIView *)superView broview:(UIView *)broview {
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"成功"];
    [superView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broview.mas_bottom).with.offset(10);
        make.left.mas_equalTo(superView).with.offset(15);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我已阅读并同意";
    label.font = font;
    [superView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broview.mas_bottom).with.offset(10);
        make.left.mas_equalTo(imageView.mas_right).with.offset(10);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"《易车易宝平台用户协定》" imageName:nil];
    [button setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [superView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(broview.mas_bottom).with.offset(10);
        make.left.mas_equalTo(label.mas_right).with.offset(0);
        make.height.mas_equalTo(15);
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