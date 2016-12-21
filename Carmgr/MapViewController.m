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

- (void)configNearbySearch {
    _mapSearch = [[AMapSearchAPI alloc] init];
    _mapSearch.delegate = self;
    
    _placeAround = [[AMapCloudPOIAroundSearchRequest alloc] init];
    [_placeAround setTableID:self.tableID];
    
    [_placeAround setRadius:1000];
    
    [_placeAround setSortFields:@"_distance"];
    [_placeAround setSortType:AMapCloudSortTypeDESC];
    
//    [_placeAround setOffset:0];
    //  [placeAround setPage:1];
}

//- (void)configNearbyManager {
//    _nearbyManager = [AMapNearbySearchManager sharedInstance];
//    _nearbyManager.delegate = self;
//}

#pragma mark - Methods

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
    } else if ([annotation isKindOfClass:[POIAnnotation class]]) {
        
        static NSString *poiAnnotationStyle = @"poiAnnotation";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:poiAnnotationStyle];
        
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiAnnotationStyle];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        
        return annotationView;
    }
    
    return nil;
}

//单击地图收起键盘
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && _locationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            _locationAnnotationView.rotateDegree = userLocation.heading.trueHeading;
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

#pragma mark - AMapSearchDelegate

- (void)onCloudSearchDone:(AMapCloudSearchBaseRequest *)request response:(AMapCloudPOISearchResponse *)response
{
    [_mapView removeAnnotations:_mapView.annotations];
    
    if (response.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.count];
    NSMutableArray *aroundData = [[NSMutableArray alloc] init];
    
    [response.POIs enumerateObjectsUsingBlock:^(AMapCloudPOI *poi, NSUInteger idx, BOOL *stop) {
        
        POIAnnotation *poiAnnotation = [[POIAnnotation alloc] initWithPOI:poi];
        
        [poiAnnotations addObject:poiAnnotation];
        
        //addData
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:poi.customFields];
        [dict setObject:poi.name forKey:@"name"];
        
        [aroundData addObject:dict];
        
    }];
    
    //返回周边搜索结果数据block
    if (self.aroundSearch) {
        self.aroundSearch(aroundData);
    }
    
    /* 将结果以annotation的形式加载到地图上. */
    [_mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
//    [_mapView showAnnotations:poiAnnotations animated:YES];
    
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
    
    //地图
    [self configMapView];
    
    //附近的人（上传过位置信息的用户）
//    [self configNearbyManager];
    
    //周边搜索
    [self configNearbySearch];
    
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
