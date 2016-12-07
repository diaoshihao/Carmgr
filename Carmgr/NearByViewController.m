//
//  NearByViewController.m
//  Carmgr
//
//  Created by admin on 2016/11/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "NearByViewController.h"
#import <AMap2DMap/MAMapKit/MAMapView.h>
#import "CurrentServiceScrollView.h"
#import "CurrentServiceModel.h"
#import "ClassifyScrollView.h"
#import "DefineValue.h"
#import <Masonry.h>
@interface NearByViewController () <MAMapViewDelegate, ClassifyScrollViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) ClassifyScrollView *classifyView;

@property (nonatomic, strong) CurrentServiceScrollView *currentServiceView;

@property (nonatomic, strong) NSMutableArray *services;

@end

@implementation NearByViewController

- (NSMutableArray *)services {
    if (_services == nil) {
        _services = [NSMutableArray new];
    }
    return _services;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    //地图
    [self configMapView];
    //分类
    [self configClassifyView];
    //简介
    [self configCurrentServiceView];
}

- (void)loadData {
    for (NSInteger i = 0; i < 3; i++) {
        CurrentServiceModel *model = [[CurrentServiceModel alloc] initWithDict:@{@"serviceName":@"testName",@"merchantName":@"testName",@"price":@"100"}];
        [self.services addObject:model];
    }
}

- (CurrentServiceScrollView *)currentServiceView {
    if (_currentServiceView == nil) {
        
    }
    return _currentServiceView;
}

- (void)configCurrentServiceView {
    self.currentServiceView = [[CurrentServiceScrollView alloc] init];
    self.currentServiceView.nearbyServices = self.services;
    [self.view addSubview:self.currentServiceView];
    [self.currentServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(self.customBar.mas_bottom).offset(10);
    }];
}

//instance classifyView
- (void)configClassifyView {
    self.classifyView = [[ClassifyScrollView alloc] initWithDelegate:self];
    [self.view addSubview:self.classifyView];
    [self.classifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
}

//instance mapView
- (void)configMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64)];
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:16 animated:YES];
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    [self.view addSubview:self.mapView];
}

#pragma mark - mapDelegate
//单击地图收起键盘
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
}

#pragma mark - classifyViewDelegate
//选择分类类型
- (void)didSelectedCurrentService:(NSString *)currentService {
    NSLog(@"%@",currentService);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.mapView.mapType = MAMapTypeStandard;
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
