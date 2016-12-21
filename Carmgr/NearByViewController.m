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
#import "Interface.h"
#import <Masonry.h>
#import "MapViewController.h"
@interface NearByViewController () <MAMapViewDelegate, ClassifyScrollViewDelegate>
{
    CLLocationCoordinate2D _recode;
}

@property (nonatomic, strong) ClassifyScrollView *classifyView;

@property (nonatomic, strong) CurrentServiceScrollView *currentServiceView;

@property (nonatomic, strong) NSMutableArray *services;

@property (nonatomic, strong) MapViewController *mapView;

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
    
//    [self loadData:@"上牌"];
    
}

- (void)addAddress {
//    NSArray *address = [Interface maddress:@"易务车宝" address:@"广东省广州市天河区车陂路" filter:@"上牌"];
////    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
//    [PPNetworkHelper POST:address[InterfaceUrl] parameters:address[Parameters] success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
}

//- (void)loadData:(NSString *)currentService {
//    NSArray *getaddress = [Interface getmerchantaddress:currentService city:@"全国"];
//    [PPNetworkHelper GET:getaddress[InterfaceUrl] parameters:getaddress[Parameters] success:^(id responseObject) {
//        [self.services removeAllObjects];
//
//        if ([responseObject[@"status"] integerValue] == 0) {
//            [self showUnknownError];
//            
//        } else if ([responseObject[@"count"] integerValue] == 0) {
//            [self showNoMerchantAlertView];
//            
//        } else {
//            NSArray *datas = responseObject[@"datas"];
//            
//            for (NSDictionary *dict in datas) {
//                CurrentServiceModel *model = [[CurrentServiceModel alloc] initWithDict:@{@"serviceName":dict[@"service_name"],@"merchantName":dict[@"_name"],@"price":dict[@"price"]}];
//                [self.services addObject:model];
//            }
//        }
//        
//        [self.currentServiceView reloadData];
//        
//    } failure:^(NSError *error) {
//        [self showFailuer];
//    }];
//}

- (void)showNoMerchantAlertView {
    [self showAlertOnlyMessage:@"您的附近暂未找到相关服务点"];
}

- (void)showUnknownError {
    [self showAlertOnlyMessage:@"未知错误"];
}

- (void)showFailuer {
    [self showAlertOnlyMessage:@"请求失败，请检查网络"];
}

//CurrentServiceView    简介
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
        });
        
        _recode = record;
    }];
    
    //获取数据block
    [self.mapView dataDidLoad:^(NSArray *data) {
        [self loadData:data];
    }];
    
    [self addChildViewController:self.mapView];
    self.mapView.view.frame = CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64);
    [self.view addSubview:self.mapView.view];
}

//加载数据
- (void)loadData:(NSArray *)datas {
    [self.services removeAllObjects];
    
    if (datas.count == 0) {
        [self showNoMerchantAlertView];
    } else {
        for (NSDictionary *dict in datas) {
            CurrentServiceModel *model = [[CurrentServiceModel alloc] initWithDict:@{@"serviceName":dict[@"service_name"],@"merchantName":dict[@"name"],@"price":dict[@"price"]}];
            [self.services addObject:model];
        }
    }
    
    //重新加载服务介绍页面
    [self.currentServiceView reloadData];
}

#pragma mark - classifyViewDelegate
//选择分类类型
- (void)didSelectedCurrentService:(NSString *)currentService {
    //发起周边检索
    [self.mapView startAroundSearch:currentService center:_recode];
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
