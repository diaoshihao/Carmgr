//
//  MapViewController.h
//  Carmgr
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

//周边搜索结果
typedef void(^AroundSearch)(NSArray *aroundData);

//当前选择的标注索引index
typedef void(^CurrentAnnotaion)(NSInteger index);

//当前定位经纬度（持续定位）
typedef void(^UpdatingLocation)(CLLocationCoordinate2D record);

@interface MapViewController : UIViewController

@property (nonatomic, copy) AroundSearch aroundSearch;

@property (nonatomic, copy) UpdatingLocation locationBlock;

@property (nonatomic, copy) CurrentAnnotaion currentBlock;

@property (nonatomic, strong) NSString *tableID;

//当前地图中心
@property (nonatomic, assign) CLLocationCoordinate2D currentRecord;

//更新当前位置（持续定位）
- (void)updatingLocation:(UpdatingLocation)location;

//显示用户位置
- (void)showUserLocation;

//开始周边搜索
- (void)startAroundSearch:(NSString *)keywords center:(CLLocationCoordinate2D)record;

//返回周边搜索数据
- (void)dataDidLoad:(AroundSearch)aroundData;

//选择当前的标注:根据滑动高亮显示对应的标注View
- (void)selectAnnotation:(NSInteger)index;

//当前选择的标注:点击标注view显示对应的服务简介的回调方法
- (void)currentAnnotationView:(CurrentAnnotaion)currentBlock;

@end
