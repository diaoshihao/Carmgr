//
//  HomeView.h
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface HomeView : UIView 

@property (nonatomic, strong) NSArray      *imageArr;//业务图片
@property (nonatomic, strong) NSArray      *titleArr;//业务标题
@property (nonatomic, strong) NSArray      *usedCarImageArr;//二手车图片
@property (nonatomic, strong) NSArray      *hotImageArr;//热门图片

@property (nonatomic, strong) NSDictionary *actImageDict;//活动图片
@property (nonatomic, strong) NSDictionary *secondImageDict;//优惠图片

@property (nonatomic, strong) UIViewController *VC;


- (SDCycleScrollView *)createCycleScrollView:(NSArray *)imageNameGroup;

- (UIView *)createServiceCollectionView;

- (UIView *)createActivetyView;

- (UIView *)createSecondView;

- (UIView *)createUsedCarCollectionView;

- (UIView *)createTableViewAtSuperView:(UIView *)superView broview:(UIView *)broview;

- (void)createHeadViewWithTitle:(NSString *)title superView:(UIView *)superView;

@end
