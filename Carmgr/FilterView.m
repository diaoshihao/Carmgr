//
//  FilterView.m
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "FilterView.h"
#import "DefineValue.h"
#import <Masonry.h>

@interface FilterView()

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation FilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configViews];
    }
    return self;
}

- (void)configViews {
    self.buttons = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"全部",@"全城市",@"默认排序"];
    for (NSInteger i = 0; i < titles.count; i++) {
        CustomButton *button = [self buttonWithTitle:titles[i]];
        button.frame = CGRectMake([DefineValue screenWidth] / 3 * i, 0, [DefineValue screenWidth] / 3, 44);
        button.tag = i + 10;
        [self addSubview:button];
        [self.buttons addObject:button];
        
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo([DefineValue screenWidth] / 3 * i);
//            make.height.mas_equalTo(self);
//        }];
    }
    
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [DefineValue separaColor];
    [self addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue pixHeight] * 2);
        make.bottom.mas_equalTo(self);
    }];
}

- (CustomButton *)buttonWithTitle:(NSString *)title {
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionRight];
    button.normalTitle = title;
    button.titleLabel.font = [DefineValue font14];
    button.normalColor = [UIColor blackColor];
    button.selectedColor = [DefineValue mainColor];
    button.normalImageName = @"下拉黑";
    button.selectedImageName = @"下拉橙";
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick:(CustomButton *)sender {
    
    for (CustomButton *button in self.buttons) {
        if (sender != button) { //不改变当前按钮的状态
            button.selected = NO;
        }
    }
    
    sender.selected = !sender.selected;
    
    //如果当前是选中状态
    if (sender.selected) {
        self.currentSelected = sender;
        FilterType filterType = sender.tag - 10;
        if (self.filterBlock) {
            self.filterBlock(filterType);
        }
    } else {
        //非选中状态
        if (self.filterBlock) {
            self.filterBlock(FilterTypeNone);
        }
    }
    
    self.currentSelected = sender;
    
}

- (void)filterTypeDidSelected:(FilterTypeSelectBlock)filterBlock {
    self.filterBlock = filterBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
