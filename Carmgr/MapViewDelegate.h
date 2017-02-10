//
//  MapViewDelegate.h
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

//定位经纬度回调
typedef void(^LocationUpdatingBlock)(CLLocationCoordinate2D location);

//用户移动地图回调
typedef void(^UserMoveMapBlock)(CLLocationCoordinate2D mapCenter);

//点击标注回调
typedef void(^CurrentAnnotationBlock)(NSInteger index);

@interface MapViewDelegate : NSObject <MAMapViewDelegate>

@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic, copy) LocationUpdatingBlock locationBlock;

@property (nonatomic, copy) UserMoveMapBlock moveMapBlock;

@property (nonatomic, copy) CurrentAnnotationBlock currentBlock;

//更新当前位置（持续定位）
- (void)locationDidUpdating:(LocationUpdatingBlock)locationBlock;

//用户移动地图
- (void)userDidMoveMapView:(UserMoveMapBlock)moveMapBlock;

//当前选择的标注:点击标注view显示对应的服务简介的回调方法
- (void)currentAnnotationView:(CurrentAnnotationBlock)currentBlock;


@end
