//
//  CurrentServiceScrollView.m
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CurrentServiceScrollView.h"
#import "CurrentServiceView.h"
#import "CurrentServiceModel.h"
#import <Masonry.h>

@interface CurrentServiceScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) CurrentServiceView *serviceView;

@end

@implementation CurrentServiceScrollView
{
    CGFloat width;//scrollView content width
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.clipsToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
        self.delegate = self;
        
        //设置superview透明度0，错误做法：self.alpha = 0;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return self;
}

- (instancetype)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.clipsToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
        self.delegate = self;
        
        //设置superview透明度0，错误做法：self.alpha = 0;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return self;
}

- (void)reloadData {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self configCurrentServiceView];
}

- (void)configCurrentServiceView {
    width = [UIScreen mainScreen].bounds.size.width - 30;
    
    self.contentSize = CGSizeMake((width + 10) * self.nearbyServices.count, 0);
    
    
    for (NSInteger i = 0; i < self.nearbyServices.count; i++) {
        CurrentServiceModel *model = self.nearbyServices[i];
        UIView *contentView = [self contentView:model];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i * (width + 10) + 10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(self);
        }];
    }
}

- (UIView *)contentView:(CurrentServiceModel *)model{
    
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    self.serviceView = [[CurrentServiceView alloc] init];
    [self configServiceView:model];
    [background addSubview:self.serviceView];
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    return background;
}

- (void)configServiceView:(CurrentServiceModel *)model {
    self.serviceView.serviceName.text = model.serviceName;
    self.serviceView.merchantName.text = model.merchantName;
    self.serviceView.price.text = [NSString stringWithFormat:@"%@ 元／单",model.price];
    self.serviceView.stars = model.stars;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = scrollView.contentOffset.x / (width + 10);
    
    if (self.currentPageBlock) {
        self.currentPageBlock(self.currentPage);
    }
}

- (void)currentServicePage:(CurrentPageBlock)currentPageBlock {
    self.currentPageBlock = currentPageBlock;
}

- (void)scrollToCurrentPage:(NSInteger)index {
    self.contentOffset = CGPointMake(index * (width + 10), 0);
}



@end
