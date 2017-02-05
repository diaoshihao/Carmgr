//
//  MapViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "LocationAnnotationView.h"
#import "CustomAnnotationView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "POIAnnotation.h"

@interface MapViewController () <MAMapViewDelegate, AMapSearchDelegate, AMapNearbySearchManagerDelegate>
{
    MAMapView *_mapView;
    LocationAnnotationView *_locationAnnotationView;
    CLLocationCoordinate2D _record;
    
//    AMapNearbySearchManager *_nearbyManager;
    
    AMapSearchAPI *_mapSearch;
    
    AMapCloudPOIAroundSearchRequest *_placeAround;
}

@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic, strong) NSString *currentKeyword;

@end

@implementation MapViewController

#pragma mark - config
- (void)configMapView {
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    [_mapView setZoomLevel:16 animated:YES];
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.view addSubview:_mapView];
}

- (void)configAroundSearch {
    _mapSearch = [[AMapSearchAPI alloc] init];
    _mapSearch.delegate = self;
    
    _placeAround = [[AMapCloudPOIAroundSearchRequest alloc] init];
    [_placeAround setTableID:self.tableID];
    
    [_placeAround setRadius:3000];
    
    [_placeAround setSortFields:@"_distance"];
    [_placeAround setSortType:AMapCloudSortTypeDESC];
}

#pragma mark - Methods

//显示用户位置
- (void)showUserLocation {
    [_mapView setCenterCoordinate:_record animated:YES];
    [self startAroundSearch:_placeAround.keywords center:_record];
    
    //当前地图中心
    self.currentRecord = _record;
}

//发起周边检索
- (void)startAroundSearch:(NSString *)keywords center:(CLLocationCoordinate2D)record {
    //center
    AMapGeoPoint *centerPoint = [AMapGeoPoint locationWithLatitude:record.latitude longitude:record.longitude];
    [_placeAround setCenter:centerPoint];
    
    //keywords
    [_placeAround setKeywords:keywords];
    
    //发起周边检索
    [_mapSearch AMapCloudPOIAroundSearch:_placeAround];
}

//获取数据回调
- (void)dataDidLoad:(AroundSearch)aroundData {
    self.aroundSearch = aroundData;
}

//位置更新回调
- (void)updatingLocation:(UpdatingLocation)location {
    self.locationBlock = location;
}

//选择当前的标注:根据滑动高亮显示对应的标注View
- (void)selectAnnotation:(NSInteger)index {
    for (POIAnnotation *poiAnnotation in self.annotations) {
        if ([poiAnnotation isEqual:self.annotations[index]]) {
            [_mapView selectAnnotation:poiAnnotation animated:NO];
            
            CustomAnnotationView *annotationView = [[CustomAnnotationView alloc] initWithAnnotation:poiAnnotation reuseIdentifier:@"poiAnnotation"];
            annotationView.frame = CGRectMake(0, 0, 60, 60);
        }
    }
}

//当前选择的标注:点击标注view显示对应的服务简介的回调方法
- (void)currentAnnotationView:(CurrentAnnotaion)currentBlock {
    self.currentBlock = currentBlock;
}

#pragma mark - MAMapViewDelegate

//定位图标指示方向
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[LocationAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        annotationView.canShowCallout = YES;
        _locationAnnotationView = (LocationAnnotationView *)annotationView;
        
        return annotationView;
        
    //地图标注view
    } else if ([annotation isKindOfClass:[POIAnnotation class]]) {
        
        static NSString *poiAnnotationStyle = @"poiAnnotation";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:poiAnnotationStyle];
        
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiAnnotationStyle];
        }
        POIAnnotation *poi = (POIAnnotation *)annotation;
        
        annotationView.frame = CGRectMake(0, 0, 48, 48);
//        [annotationView setCenterOffset:CGPointMake(0, annotationView.frame.size.height/2)];
        
        annotationView.merchantImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:poi.poi.images.firstObject.preurl]]];
        
        return annotationView;
    }
    
    return nil;
}

//单击地图收起键盘
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.currentBlock) {
        self.currentBlock(-1);
    }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        NSInteger index = [self.annotations indexOfObject:view.annotation];
        if (self.currentBlock) {
            self.currentBlock(index);
        }
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && _locationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            _locationAnnotationView.rotateDegree = userLocation.heading.magneticHeading;
        }];
    }
    
    if (_record.latitude != userLocation.coordinate.latitude || _record.longitude != userLocation.coordinate.longitude) {
        _record = userLocation.coordinate;
        
        //返回当前经纬度回调
        if (self.locationBlock) {
            self.locationBlock(_record);
        }
    }
}

//移动地图
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    //用户移动地图
    if (wasUserAction) {
        [self startAroundSearch:_placeAround.keywords center:mapView.centerCoordinate];
        
        //当前地图中心
        self.currentRecord = mapView.centerCoordinate;
    }
}

#pragma mark - AMapSearchDelegate

//云图搜索结果
- (void)onCloudSearchDone:(AMapCloudSearchBaseRequest *)request response:(AMapCloudPOISearchResponse *)response
{
    [_mapView removeAnnotations:_mapView.annotations];
    
    if (response.count == 0)
    {
        if (self.aroundSearch) {
            self.aroundSearch(nil);
        }
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.count];
    NSMutableArray *aroundData = [[NSMutableArray alloc] init];
    
    [response.POIs enumerateObjectsUsingBlock:^(AMapCloudPOI *poi, NSUInteger idx, BOOL *stop) {
        
        //自定义地图标注内容
        POIAnnotation *poiAnnotation = [[POIAnnotation alloc] initWithPOI:poi];
        
        [poiAnnotations addObject:poiAnnotation];
        
        //addData 在返回的数据字典中增加 name 字段
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:poi.customFields];
        [dict setObject:poi.name forKey:@"name"];
        
        
        NSString *uid = [NSString stringWithFormat:@"%ld",poi.uid];
        [dict setObject:uid forKey:@"uid"];
        
        [aroundData addObject:dict];
        
    }];
    
    self.annotations = poiAnnotations;
    
    //返回周边搜索结果数据block
    if (self.aroundSearch) {
        self.aroundSearch(aroundData);
    }
    
    /* 将结果以annotation的形式加载到地图上. */
    [_mapView addAnnotations:poiAnnotations];
    
    //默认第一条标注高亮显示
    [self selectAnnotation:0];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    
}

#pragma mark - AMapNearbySearchManagerDelegate

- (AMapNearbyUploadInfo *)nearbyInfoForUploading:(AMapNearbySearchManager *)manager
{
    AMapNearbyUploadInfo *info = [[AMapNearbyUploadInfo alloc] init];
    info.userID = @"1";
    info.coordinate = _record;
    
    return info;
}

#pragma mark - Lift Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //地图
    [self configMapView];
    
    //附近的人（上传过位置信息的用户）
//    [self configNearbyManager];
    
    //周边搜索
    [self configAroundSearch];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [_nearbyManager startAutoUploadNearbyInfo];//开启自动上传
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [_nearbyManager stopAutoUploadNearbyInfo];//关闭自动上传
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
