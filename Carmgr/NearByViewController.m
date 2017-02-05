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
#import "MapViewController.h"
#import "DefineValue.h"
#import "Interface.h"
#import <Masonry.h>
@interface NearByViewController () <MAMapViewDelegate, ClassifyScrollViewDelegate>
{
    CLLocationCoordinate2D _recode;//用户位置
}

@property (nonatomic, strong) ClassifyScrollView *classifyView;

@property (nonatomic, strong) CurrentServiceScrollView *currentServiceView;

@property (nonatomic, strong) NSMutableArray *services;

@property (nonatomic, strong) MapViewController *mapView;

@property (nonatomic, strong) MASConstraint *heightLayout;

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
    
    //地图
    [self configMapView];
    
    //分类
    [self configClassifyView];
    
    //简介
    [self configCurrentServiceView];
    
    //显示用户位置按钮
    [self addLocationButtonToMapView];
}

//CurrentServiceView    简介
- (void)configCurrentServiceView {
    self.currentServiceView = [[CurrentServiceScrollView alloc] init];
    self.currentServiceView.nearbyServices = self.services;
    [self.view addSubview:self.currentServiceView];
    
    //滑动后显示对应的标注
    [self.currentServiceView currentServicePage:^(NSInteger index) {
        [self.mapView selectAnnotation:index];
    }];
    
    [self.currentServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(self.customBar.mas_bottom).offset(10);
    }];
}

//instance classifyView   分类
- (void)configClassifyView {
    self.classifyView = [[ClassifyScrollView alloc] initWithDelegate:self];
    [self.view addSubview:self.classifyView];

    [self.classifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
}

//instance mapView    地图
- (void)configMapView {
    self.mapView = [[MapViewController alloc] init];
    self.mapView.tableID = [Interface tableid];//周边检索必须赋值
    
    //周边搜索block（初次进入地图界面）
    [self.mapView updatingLocation:^(CLLocationCoordinate2D record) {
        //执行一次周边搜索
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //发起周边检索
            [self.mapView startAroundSearch:@"上牌" center:record];
            
            //当前地图中心(第一次进入地图，设置地图中心为用户当前位置)
            self.mapView.currentRecord = record;
        });
        
        _recode = record;
    }];
    
    //获取周边搜索结果数据block
    [self.mapView dataDidLoad:^(NSArray *data) {
        if (data == nil) {
            [self setServicePageHidden:YES];
            return;
        }
        [self loadData:data];
    }];
    
    //当前选择的标注
    [self.mapView currentAnnotationView:^(NSInteger index) {
        if (index == -1) {
            [self setServicePageHidden:YES];
        } else {
            [self setServicePageHidden:NO];
            [self.currentServiceView scrollToCurrentPage:index];
        }
    }];
    
    [self addChildViewController:self.mapView];
    self.mapView.view.frame = CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64);
    [self.view addSubview:self.mapView.view];
}

//添加显示用户位置的按钮
- (void)addLocationButtonToMapView {
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    [location setImage:[UIImage imageNamed:@"用户位置"] forState:UIControlStateNormal];
    location.backgroundColor = [UIColor whiteColor];
    [location addTarget:self action:@selector(userLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:location];
    
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.mas_equalTo(self.classifyView.mas_top).offset(-20);
    }];
}

- (void)userLocation {
    [self.mapView showUserLocation];
}

//加载数据
- (void)loadData:(NSArray *)datas {
    [self.services removeAllObjects];
    
    if (datas.count == 0) {
        [self setServicePageHidden:YES];;
    } else {
        for (NSDictionary *dict in datas) {
            CurrentServiceModel *model = [[CurrentServiceModel alloc] initWithDict:@{@"serviceName":dict[@"service_name"],@"merchantName":dict[@"name"],@"price":dict[@"price"],@"uid":dict[@"uid"]}];
            [self.services addObject:model];
        }
        
        [self showCurrentService];
    }
}

- (void)setServicePageHidden:(BOOL)hidden {
    [UIView animateWithDuration:0.618 animations:^{
        if (hidden) {
            self.currentServiceView.alpha = 0;
        } else {
            self.currentServiceView.alpha = 1;
        }
    }];
}

- (void)showCurrentService {
    [self.currentServiceView reloadData];
    [self setServicePageHidden:NO];
}


#pragma mark - classifyViewDelegate
//选择分类类型
- (void)didSelectedCurrentService:(NSString *)currentService {
    //发起周边检索
    [self.mapView startAroundSearch:currentService center:self.mapView.currentRecord];
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
