//
//  CallView.m
//  Carmgr
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CallView.h"

@implementation CallView

- (UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, height-107)];
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}

- (UITextField *)textField:(NSString *)placeholer {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholer;
    textField.returnKeyType = UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor colorWithRed:153/256.0 green:153/256.0 blue:153/256.0 alpha:1];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius = 6;
    textField.clipsToBounds = YES;
    textField.layer.borderWidth = 2;
    textField.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
    return textField;
}

- (UIButton *)button:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UILabel *)label:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
