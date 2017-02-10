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
#import "MerchantViewController.h"
#import "ForHelpViewController.h"
#import "CurrentServiceModel.h"
#import "ClassifyScrollView.h"
#import "MapViewController.h"
#import "ForHelpView.h"
#import "DefineValue.h"
#import "Interface.h"
#import <Masonry.h>

@interface NearByViewController () <MAMapViewDelegate, ClassifyScrollViewDelegate>

@property (nonatomic, strong) ClassifyScrollView *classifyView;

@property (nonatomic, strong) CurrentServiceScrollView *currentServiceView;

@property (nonatomic, strong) NSMutableArray *services;

@property (nonatomic, strong) MapViewController *mapViewVC;

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
    
    //添加商家列表的按钮
    [self addMerchantListButtonToMapView];
    
    //添加发布消息的按钮
    [self addPublicButtonToMapView];
    
}

//CurrentServiceView    简介
- (void)configCurrentServiceView {
    self.currentServiceView = [[CurrentServiceScrollView alloc] init];
    self.currentServiceView.nearbyServices = self.services;
    [self.view addSubview:self.currentServiceView];
    
    //滑动后显示对应的标注
    [self.currentServiceView currentServicePage:^(NSInteger index) {
        [self.mapViewVC selectAnnotation:index];
    }];
    
    [self.currentServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(0);
        make.top.mas_equalTo(self.customBar.mas_bottom).offset(10);
    }];
    
    [self.currentServiceView.superview layoutIfNeeded];
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
    self.mapViewVC = [[MapViewController alloc] init];
    
    //获取周边搜索结果数据block
    [self.mapViewVC dataDidLoad:^(NSArray *data) {
        if (data == nil) {
            [self setServicePageHidden:YES];
            return;
        }
        [self loadData:data];
    }];
    
    [self addChildViewController:self.mapViewVC];
    self.mapViewVC.view.frame = CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64);
    [self.view addSubview:self.mapViewVC.view];
    
    //添加观察者
    [self.mapViewVC addObserver:self forKeyPath:@"annotationIndex" options:NSKeyValueObservingOptionNew context:nil];
}

//观察标注索引号annotationIndex值的变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSInteger index = [change[@"new"] integerValue];
    if (index == -1) {
        [self setServicePageHidden:YES];
    } else {
        [self setServicePageHidden:NO];
        [self.currentServiceView scrollToCurrentPage:index];
    }
}

//移除观察者
- (void)dealloc {
    [self.mapViewVC removeObserver:self forKeyPath:@"annotationIndex"];
}

//添加显示用户位置的按钮
- (void)addLocationButtonToMapView {
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    [location setImage:[UIImage imageNamed:@"用户位置"] forState:UIControlStateNormal];
    location.backgroundColor = [UIColor whiteColor];
    [location addTarget:self action:@selector(userLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:location];
    
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.mas_equalTo(self.classifyView.mas_top).offset(-20);
    }];
}

//显示用户位置
- (void)userLocation {
    [self.mapViewVC showUserLocation];
}

//添加商家列表的按钮
- (void)addMerchantListButtonToMapView {
    UIButton *merchantList = [UIButton buttonWithType:UIButtonTypeCustom];
    [merchantList setImage:[UIImage imageNamed:@"列表"] forState:UIControlStateNormal];
    merchantList.backgroundColor = [UIColor whiteColor];
    [merchantList addTarget:self action:@selector(merchantList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:merchantList];
    
    [merchantList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(self.currentServiceView.mas_bottom).offset(10);
    }];
}

- (void)merchantList {
    MerchantViewController *merchantVC = [[MerchantViewController alloc] init];
    [self.navigationController pushViewController:merchantVC animated:YES];
}

//添加发布消息的按钮
- (void)addPublicButtonToMapView {
    UIButton *public = [UIButton buttonWithType:UIButtonTypeCustom];
    [public setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    [public setBackgroundColor:[UIColor whiteColor]];
    [public addTarget:self action:@selector(pushToHelpVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:public];
    
    [public mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(self.currentServiceView.mas_bottom).offset(70);
    }];
}

- (void)forHelp {
    ForHelpView *helpView = [[ForHelpView alloc] init];
    helpView.frame = [UIScreen mainScreen].bounds;
    [helpView needForHelp:^{
        [helpView removeFromSuperview];
        [self pushToHelpVC];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:helpView];
}

- (void)pushToHelpVC {
    ForHelpViewController *forHelpVC = [[ForHelpViewController alloc] init];
    [self.navigationController pushViewController:forHelpVC animated:YES];
}

//加载数据
- (void)loadData:(NSArray *)datas {
    [self.services removeAllObjects];
    
    if (datas.count == 0) {
        [self setServicePageHidden:YES];;
    } else {
        for (NSDictionary *dict in datas) {
            CurrentServiceModel *model = [[CurrentServiceModel alloc] initWithDict:@{@"serviceName":dict[@"service_name"],@"merchantName":dict[@"name"],@"stars":dict[@"stars"],@"price":dict[@"price"],@"uid":dict[@"uid"]}];
            [self.services addObject:model];
        }
        
        [self showCurrentService];
    }
}

- (void)setServicePageHidden:(BOOL)hidden {
    if (hidden) {
        [UIView animateWithDuration:0.618 animations:^{
            [self.currentServiceView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            [self.currentServiceView.superview layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.618 animations:^{
            [self.currentServiceView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(120);
            }];
            [self.currentServiceView.superview layoutIfNeeded];
        }];
        
    }
}

- (void)showCurrentService {
    [self.currentServiceView reloadData];
    
    [self.currentServiceView.superview layoutIfNeeded];
    [self setServicePageHidden:NO];
}


#pragma mark - classifyViewDelegate
//选择分类类型
- (void)didSelectedCurrentService:(NSString *)currentService {
    //发起周边检索
    [self.mapViewVC startAroundSearchWithKeywords:currentService center:self.mapViewVC.mapCenter];
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
