//
//  StoreViw.h
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, SortKey) {
    SortByNone = 0, //不排序
    SortByService = 1,  //全部
    SortByArea,     //全城市
    SortByDefault   //默认排序
};

@interface StoreView : UIView

@property (nonatomic, strong) NSArray           *sortArr;//当前排序名数据
@property (nonatomic, strong) NSMutableArray    *dataArr;//主页面数据
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UITableView       *sortTableView;

@property (nonatomic, assign) SortKey sortkey;

@property (nonatomic, strong) BaseViewController *VC;
@property (nonatomic, strong) NSString *service_filter;//当前服务分类

//排序View
- (void)createHeadSortViewAtSuperView:(UIView *)superView;

- (void)createTableView:(UIView *)superView;

@end
