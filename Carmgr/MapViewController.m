//
//  MapViewController.m
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "MapViewController.h"
#import "MapInterface.h"
#import "POIAnnotation.h"
#import "MapSearchAssistant.h"
#import "CustomAnnotationView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface MapViewController ()

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) MapSearchAssistant *mapSearchAssistant;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configMapView];
    [self configMapViewDelegate];
    [self configMapSearch];
}

//地图显示
- (void)configMapView {
    [AMapServices sharedServices].apiKey = [MapInterface mapApiKey];
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    [self.mapView setZoomLevel:16 animated:YES];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

//地图周边搜索
- (void)configMapSearch {
    self.mapSearchAssistant = [[MapSearchAssistant alloc] init];
    self.mapSearchAssistant.tableID = [MapInterface tableID];
    [self.mapSearchAssistant cloudPOIsDidLoad:^(NSArray *POIs) {
        [self addAnnotationViews:POIs];
    }];
}

//地图代理
- (void)configMapViewDelegate {
    self.mapViewDelegate = [[MapViewDelegate alloc] init];
    self.mapView.delegate = self.mapViewDelegate;
    
    //更新当前位置（持续定位）
    [self.mapViewDelegate locationDidUpdating:^(CLLocationCoordinate2D location) {
        self.location = location;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //初始化一次地图中心
            self.mapCenter = location;
            
            [self startAroundSearchWithKeywords:@"上牌" center:location];
        });
    }];
    
    [self.mapViewDelegate currentAnnotationView:^(NSInteger index) {
        self.annotationIndex = index;
    }];
    
    //用户移动地图回调
    [self.mapViewDelegate userDidMoveMapView:^(CLLocationCoordinate2D mapCenter) {
        self.mapCenter = mapCenter;
        self.mapSearchAssistant.center = mapCenter;
        [self.mapSearchAssistant startMapSearchAround];
    }];
}

//选择当前的标注:根据滑动高亮显示对应的标注View
- (void)selectAnnotation:(NSInteger)index {
    for (POIAnnotation *poiAnnotation in self.mapViewDelegate.annotations) {
        if ([poiAnnotation isEqual:self.mapViewDelegate.annotations[index]]) {
            [self.mapView selectAnnotation:poiAnnotation animated:NO];
            
            CustomAnnotationView *annotationView = [[CustomAnnotationView alloc] initWithAnnotation:poiAnnotation reuseIdentifier:@"poiAnnotation"];
            annotationView.frame = CGRectMake(0, 0, 60, 60);
        }
    }
}

//将结果以annotation的形式加载到地图上
- (void)addAnnotationViews:(NSArray *)POIs {
    [self.mapView removeAnnotations:_mapView.annotations];
    
    if (POIs.count == 0)
    {
        if (self.aroundSearch) {
            self.aroundSearch(nil);
        }
        return;
    }
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:POIs.count];
    NSMutableArray *aroundData = [[NSMutableArray alloc] init];
    
    [POIs enumerateObjectsUsingBlock:^(AMapCloudPOI *poi, NSUInteger idx, BOOL *stop) {
        
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
    
    self.mapViewDelegate.annotations = poiAnnotations;
    
    //返回周边搜索结果数据block
    if (self.aroundSearch) {
        self.aroundSearch(aroundData);
    }
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    //默认第一条标注高亮显示
    [self selectAnnotation:0];
}

//显示用户位置
- (void)showUserLocation {
    //地图中心
    self.mapCenter = self.location;
    
    [self.mapView setCenterCoordinate:self.location animated:YES];
}

//开始周边搜索
- (void)startAroundSearchWithKeywords:(NSString *)keywords center:(CLLocationCoordinate2D)center {
    self.mapSearchAssistant.keywords = keywords;
    self.mapSearchAssistant.center = center;
    [self.mapSearchAssistant startMapSearchAround];
}

#pragma mark - Block
- (void)dataDidLoad:(AroundSearchBlock)aroundData {
    self.aroundSearch = aroundData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
