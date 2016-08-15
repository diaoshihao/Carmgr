//
//  DetailView.h
//  Carmgr
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
#import "DetailModel.h"
#import "RateModel.h"
#import <Masonry.h>

@interface DetailView : UIView

@property (nonatomic, strong) UIViewController  *target;
@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) NSMutableArray    *services_list;
@property (nonatomic, strong) NSMutableArray    *rate_list;

@property (nonatomic, assign) CGFloat           contentHeight;//RateTbl

- (SDCycleScrollView *)createCycleScrollView:(id)delegate imageGroup:(NSArray *)imageNameGroup;

- (UIView *)headViewWithTitle:(NSString *)title stars:(NSString *)stars;

- (UIButton *)addressButton:(NSString *)title;

- (UILabel *)multiLineLabel:(NSString *)text;

- (UIButton *)moreButton;

- (UITableView *)createTableView;

- (UITableView *)createRateTableView;

- (UIView *)contactView;
@end
