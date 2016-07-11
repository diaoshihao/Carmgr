//
//  StoreViw.h
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SortKey){
    SortByNone = 0, //不排序
    SortByAll = 1,  //全部
    SortByCity,     //全城市
    SortByDefault   //默认排序
};

@interface StoreView : UIView

@property (nonatomic, strong) NSArray *sortArr;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) SortKey sortkey;

//排序View
- (void)createHeadSortViewAtSuperView:(UIView *)superView;

- (void)createTableView:(UIView *)superView;

@end
