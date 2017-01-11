//
//  YWHomeViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWHomeViewController.h"
#import "HomeView.h"
#import "YWLoginViewController.h"
#import "ServiceViewController.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "HomeDataLoader.h"
#import "HomeModel.h"

#import "CycleScrollView.h"
#import "PromotionView.h"
#import "ServiceCollectionView.h"
#import "SecondHandCollectionView.h"
#import "SingleLocation.h"


#import "MerchantViewController.h"

@interface YWHomeViewController () <HomeDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) HomeDataLoader *dataLoader;

@property (nonatomic, strong) CycleScrollView *cycleScrollView;
@property (nonatomic, strong) ServiceCollectionView *serviceCollection;
@property (nonatomic, strong) PromotionView *promotionView;
@property (nonatomic, strong) DiscountView *discountView;
@property (nonatomic, strong) SecondHandCollectionView *secondHandCollection;

@end

@implementation YWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //默认配置
    [self config];
    
    //实例化加载数据类
    [self instanceDataLoader];
    
    //展示页面
    [self showPage];
    
    //刷新（获取数据）
    [self refresh];
    
    SingleLocation *singleLocation = [[SingleLocation alloc] init];
    [singleLocation locationComplete:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
    }];
    
}

//默认配置
- (void)config {
//    NSString *name = @[][2];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"exception"] == YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"异常崩溃" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"exception"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        [alert addAction:cancel];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

//展示页面
- (void)showPage {
    [self initContentView];
    [self addViewToContentView];
    
    //添加下拉刷新控件
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //加载数据
        [self.dataLoader loadData];
    }];
}

//实例化加载数据类
- (void)instanceDataLoader {
    self.dataLoader = [[HomeDataLoader alloc] init];
    self.dataLoader.dataSource = self;
}

//实现父类的刷新方法
- (void)refresh {
    [self.scrollView.mj_header beginRefreshing];
}

#pragma mark - homeDataSource
//所有请求已完成代理方法
- (void)requestAllDone {
    [self.scrollView.mj_header endRefreshing];
}

//所有数据获取成功代理方法
- (void)loadSuccess {
    
}

//数据获取失败代理方法
- (void)loadFailed {
    
}

//根据key加载图片
- (void)loadConfig_key:(Config_Key)config_key data:(NSArray *)data {
    [self loadImageWithKey:config_key data:data];
}

//加载服务数据
- (void)loadServices:(NSArray *)services {
    NSMutableArray *servicesArr = [NSMutableArray new];
    for (NSDictionary *dict in services) {
        ServiceModel *model = [[ServiceModel alloc] initWithDict:dict];
        [servicesArr addObject:model];
    }
    self.serviceCollection.dataArr = servicesArr;
    [self.serviceCollection reloadData];
}

//加载二手车数据
- (void)loadSecondHand:(NSArray *)secondHand {
    NSMutableArray *secondHandArr = [NSMutableArray new];
    for (NSDictionary *dict in secondHand) {
        UsedCarModel *model = [[UsedCarModel alloc] initWithDict:dict];
        [secondHandArr addObject:model];
    }
    self.secondHandCollection.dataArr = secondHandArr;
    [self.secondHandCollection reloadData];
}

//根据key给两个板块加载图片
- (void)loadImageWithKey:(Config_Key)config_key data:(NSArray *)data {
    NSMutableArray *images = [NSMutableArray new];
    for (NSDictionary *dict in data) {
        HomeModel *homeModel = [HomeModel modelWithDict:dict];
        [images addObject:homeModel.config_value];
    }
    if (config_key == Config_ZY0001) {
        self.cycleScrollView.images = images;
    } else if (config_key == Config_ZY0002) {
        [self.promotionView setImageFor:ButtonPositionLeft imageUrl:images.firstObject];
    } else if (config_key == Config_ZY0003) {
        [self.promotionView setImageFor:ButtonPositionRightTop imageUrl:images.firstObject];
    } else if (config_key == Config_ZY0004) {
        [self.promotionView setImageFor:ButtonPositionRightBottom imageUrl:images.firstObject];
    }else if (config_key == Config_ZY0005) {
        [self.discountView setDiscountImages:images];
    } else {
        
    }
}

//对应服务列表页面
- (void)pushToServicePage:(ServiceModel *)model {
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    serviceVC.service_filter = model.service_name;

    [self.navigationController pushViewController:serviceVC animated:YES];
}

//二手车查看更多
- (void)lookForMoreSecondHandInfo {
    
}

//点击轮播图
- (void)cycleImageDidTap {
    
}

//活动板块图片按钮点击事件
- (void)promotionButtonDidTap:(ButtonPosition)position {
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    NSString *service_filter = @"";
    NSArray *filters = @[@"保养",@"维修",@"加油"];
    if (position == ButtonPositionLeft) {
        service_filter = filters.firstObject;
    } else if (position == ButtonPositionRightTop) {
        service_filter = filters[1];
    } else if (position == ButtonPositionRightBottom) {
        service_filter = filters.lastObject;
    }
    serviceVC.service_filter = service_filter;
    
    [self.navigationController pushViewController:serviceVC animated:YES];
}

//优惠板块图片按钮点击事件
- (void)discountButtonDidTap:(ButtonPosition)position {
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    NSString *service_filter = @"";
    NSArray *filters = @[@"二手车",@"代驾",@"养车",@"车险",@"保养",@"保养"];
    if (position == ButtonPositionLeftTop) {
        service_filter = filters[0];
    } else if (position == ButtonPositionLeftMiddle) {
        service_filter = filters[1];
    } else if (position == ButtonPositionLeftBottom) {
        service_filter = filters[2];
    } else if (position == ButtonPositionRightTop) {
        service_filter = filters[3];
    } else if (position == ButtonPositionRightMiddle) {
        service_filter = filters[4];
    } else if (position == ButtonPositionRightBottom) {
        service_filter = filters[5];
    }
    serviceVC.service_filter = service_filter;
    
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark -
//实例化滑动页面
- (void)initContentView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [DefineValue separaColor];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo([DefineValue screenWidth]);
    }];
}

//将视图添加到可滑动页面并自动布局
- (void)addViewToContentView {
    //    轮播图
    [self configCycleScrollView];
    //    服务
    [self configServiceCollection];
    //    活动
    [self configPromotionView];
    //    优惠
    [self configDiscountView];
    //    二手车
    [self configSecondHandCollection];
}

//轮播图
- (void)configCycleScrollView {
    __weak typeof(self) weakSelf = self;
    self.cycleScrollView = [[CycleScrollView alloc] init];
    [self.cycleScrollView imageViewDidTap:^(NSUInteger index) {
        [weakSelf cycleImageDidTap];
    }];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 300 / 720);
    }];
}

//服务
- (void)configServiceCollection {
    __weak typeof(self) weakSelf = self;
    CGFloat itemWidth = ([DefineValue screenWidth] - 27.5 * 4 - 20 * 2) / 5;
    self.serviceCollection = [[ServiceCollectionView alloc] init];
    self.serviceCollection.didSelectItem = ^(ServiceModel *model) {
        [weakSelf pushToServicePage:model];
    };
    [self.contentView addSubview:self.serviceCollection];
    [self.serviceCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(2 * itemWidth + 100);
    }];
}

//活动
- (void)configPromotionView {
    __weak typeof(self) weakSelf = self;
    CGFloat promotionHeight = [DefineValue screenWidth] / 2 * 26 / 36;
    self.promotionView = [[PromotionView alloc] init];
    self.promotionView.click = ^(ButtonPosition position) {
        [weakSelf promotionButtonDidTap:position];
    };
    [self.contentView addSubview:self.promotionView];
    [self.promotionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.serviceCollection.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(promotionHeight);
    }];
}

//优惠
- (void)configDiscountView {
    __weak typeof(self) weakSelf = self;
    CGFloat discountHeight = 3 * [DefineValue screenWidth] / 2 * 13 / 36;
    self.discountView = [[DiscountView alloc] init];
    self.discountView.click = ^(ButtonPosition position) {
        [weakSelf discountButtonDidTap:position];
    };
    [self.contentView addSubview:self.discountView];
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.promotionView.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(discountHeight);
    }];
}

//二手车
- (void)configSecondHandCollection {
    __weak typeof(self) weakSelf = self;
    CGFloat secondwidth = [DefineValue screenWidth] / 4;
    CGFloat height = secondwidth * 124 / 170 + 60;
    self.secondHandCollection = [[SecondHandCollectionView alloc] init];
    self.secondHandCollection.lookMore = ^() {
        [weakSelf lookForMoreSecondHandInfo];
    };
    [self.contentView addSubview:self.secondHandCollection];
    [self.secondHandCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discountView.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
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
