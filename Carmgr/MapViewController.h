//
//  MapViewController.h
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewDelegate.h"

//周边搜索结果
typedef void(^AroundSearchBlock)(NSArray *aroundData);

@interface MapViewController : UIViewController

@property (nonatomic, strong) MapViewDelegate *mapViewDelegate;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@property (nonatomic, assign) CLLocationCoordinate2D mapCenter;

@property (nonatomic, copy) AroundSearchBlock aroundSearch;

@property (nonatomic, assign) NSInteger annotationIndex;//标注索引号

- (void)showUserLocation;

//开始周边搜索
- (void)startAroundSearchWithKeywords:(NSString *)keywords center:(CLLocationCoordinate2D)center;

//返回周边搜索数据
- (void)dataDidLoad:(AroundSearchBlock)aroundData;

//选择当前的标注:根据滑动高亮显示对应的标注View
- (void)selectAnnotation:(NSInteger)index;

@end
