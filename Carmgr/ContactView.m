//
//  ContactView.m
//  Carmgr
//
//  Created by admin on 2016/12/29.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ContactView.h"
#import "CustomButton.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation ContactView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self configVeiw];
    }
    return self;
}

- (void)configVeiw {
    [self configContactButton];
    [self configSubscribeView];
}

- (void)configContactButton {
    UIView *background = [[UIView alloc] init];
    [self addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
    }];
    
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:3];
    
    NSArray *titles = @[@"微信",@"QQ",@"电话"];
    NSArray *images = @[@"微信联系",@"QQ联系",@"电话联系"];
    for (NSInteger i = 0; i < 3; i++) {
        CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionUpper];
        button.backgroundColor = [UIColor whiteColor];
        button.normalTitle = titles[i];
        button.normalImageName = images[i];
        button.normalColor = [DefineValue buttonColor];
        button.titleLabel.font = [DefineValue font12];
        button.tag = i + 10;
        [button addTarget:self action:@selector(contactAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:button];
        [buttons addObject:button];
    }
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:[DefineValue pixHeight] * 2 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)configSubscribeView {
    CustomButton *button = [CustomButton buttonWithTitle:@"业务预约"];
    button.backgroundColor = [DefineValue mainColor];
    button.normalColor = [UIColor whiteColor];
    button.titleLabel.font = [DefineValue font16];
    [button addTarget:self action:@selector(subscribeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
    }];
}

- (void)contactAction:(CustomButton *)sender {
    ContactWith contact = sender.tag - 10;
    if (self.contactBlock) {
        self.contactBlock(contact);
    }
}

- (void)subscribeAction:(CustomButton *)sender {
    if (self.subscribeBlock) {
        self.subscribeBlock();
    }
}

- (void)contactBegin:(ContactBlock)contactBlock {
    self.contactBlock = contactBlock;
}

- (void)subscribeBegin:(SubscribeBlock)subscribeBlock {
    self.subscribeBlock = subscribeBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
