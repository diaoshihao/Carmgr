//
//  CustomTextView.m
//  Carmgr
//
//  Created by admin on 2017/2/8.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CustomTextView.h"
#import <Masonry.h>

@interface CustomTextView() <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation CustomTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configLabel];
        self.delegate = self;
        self.font = [UIFont systemFontOfSize:17];
        self.limitWords = 0;
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

- (void)configLabel {
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(self);
        make.height.mas_lessThanOrEqualTo(self);
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (range.location == 0) {
        if (text.length == 0) {
            self.placeholderLabel.text = self.placeholder;
        } else {
            self.placeholderLabel.text = nil;
        }
    }

    return YES;
}

@end
