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
@property (nonatomic, strong) NSArray      *hotImageArr;//热门图片

@property (nonatomic, strong) NSMutableArray    *actLeftArr;//活动左
@property (nonatomic, strong) NSMutableArray    *actTopArr;//活动上
@property (nonatomic, strong) NSMutableArray    *actBottomArr;//活动下
@property (nonatomic, strong) NSMutableArray    *discountArr;//优惠
@property (nonatomic, strong) NSMutableArray    *usedCarImageArr;//二手车图片

@property (nonatomic, strong) UIViewController *VC;


- (SDCycleScrollView *)createCycleScrollView:(NSArray *)imageNameGroup;

- (UIView *)createServiceCollectionView;

- (UIView *)createActivetyView;

- (UIView *)createSecondView;

- (UIView *)createUsedCarCollectionView;

- (UIView *)createTableViewAtSuperView:(UIView *)superView;

- (void)createHeadViewWithTitle:(NSString *)title superView:(UIView *)superView;

@end
