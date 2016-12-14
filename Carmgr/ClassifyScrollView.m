//
//  ClassifyScrollView.m
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ClassifyScrollView.h"
#import "CustomSegmentedControl.h"
#import <Masonry.h>

@interface ClassifyScrollView()

@property (nonatomic, strong) CustomSegmentedControl *segmented;

@end

@implementation ClassifyScrollView

- (NSArray *)services {
    if (_services == nil) {
        _services = @[@"上牌",@"驾考",@"车险",@"检车",@"维修",@"租车",@"保养",@"二手车",@"车贷",@"新车",@"急救",@"用品",@"停车"];
    }
    return _services;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounces = NO;
        [self configClassifyView];
    }
    return self;
}

- (instancetype)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.bounces = NO;
        self.classifyDelegate = delegate;
        [self configClassifyView];
    }
    return self;
}

- (void)configClassifyView {
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(44);
    }];
    
    self.segmented = [[CustomSegmentedControl alloc] initWithItems:self.services];
    self.segmented.selectedSegmentIndex = 0;
    self.currentService = self.services.firstObject;
    [self.segmented addTarget:self action:@selector(didSelectClassOfServices:) forControlEvents:UIControlEventValueChanged];
    [contentView addSubview:self.segmented];
    [self.segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)didSelectClassOfServices:(CustomSegmentedControl *)segmented {
    //delegate
    [self.classifyDelegate didSelectedCurrentService:self.services[segmented.selectedSegmentIndex]];
    //block
//    if ([self respondsToSelector:@selector(didSelectedCurrentService:)]) {
//        self.selectService(self.services[segmented.selectedSegmentIndex]);
//    }
}

- (void)didSelectedCurrentService:(SelectService)seleted {
    self.selectService = seleted;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
