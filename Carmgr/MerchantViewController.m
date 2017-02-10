//
//  MerchantViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MerchantViewController.h"
#import "MerchantTableViewController.h"
#import "UIViewController+ShowView.h"
#import "SortTableViewController.h"
#import "AlertShowAssistant.h"
#import "AddressManager.h"
#import "FilterView.h"
#import "MJRefresh.h"
#import "Interface.h"
#import <Masonry.h>

@interface MerchantViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *sortArr;

@property (nonatomic, strong) FilterView *filterView;

@property (nonatomic, strong) UITableView *merchantTableView;

@property (nonatomic, strong) SortTableViewController *sortTVC;

@property (nonatomic, strong) NSString *serviceFilter;
@property (nonatomic, strong) NSString *areaFitler;
@property (nonatomic, strong) NSString *sortFilter;

@end

@implementation MerchantViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (NSMutableArray *)sortArr {
    if (_sortArr == nil) {
        _sortArr = [NSMutableArray new];
    }
    return _sortArr;
}

- (void)loadData {
    //参数
    NSString *city_filter = [self currentCity];
    
    NSString *service_filter = self.serviceFilter;
    
    NSArray *merchants = [Interface appgetmerchantslist_city_filter:city_filter service_filter:service_filter];
    [MyNetworker POST:merchants[InterfaceUrl] parameters:merchants[Parameters] success:^(id responseObject) {
        
        [self.merchantTableView.mj_header endRefreshing];
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self.dataArr removeAllObjects];
            
            for (NSDictionary *dict in responseObject[@"merchants_list"]) {
                
                MerchantModel *model = [[MerchantModel alloc] initWithDict:dict];
                [self.dataArr addObject:model];
            }
            
            [self.merchantTableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.merchantTableView.mj_header endRefreshing];
        [AlertShowAssistant alertTip:@"提示" message:@"刷新数据失败，请重试" actionTitle:@"确定" defaultHandle:^{
        } cancelHandle:nil];
    }];
}

//根据选择的筛选条件加载排序数据源
- (void)loadFilterData:(FilterType)filterType {
    if (filterType == FilterTypeService) {
        [self filterService];
    } else if (filterType == FilterTypeArea) {
        [self filterArea];
    } else if (filterType == FilterTypeSort) {
        [self filterSort];
    } else {
        return;
    }
}

//设置当前筛选条件
- (void)filterString:(NSString *)filter filterType:(FilterType)filterType {
    if (filterType == FilterTypeService) {
        self.serviceFilter = filter;
    } else if (filterType == FilterTypeArea) {
        self.areaFitler = filter;
    } else if (filterType == FilterTypeSort) {
        self.sortFilter = filter;
    } else {
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self baseConfig];
    [self configView];
    [self refresh];
}

- (void)baseConfig {
    self.title = @"商家列表";
    self.showShadow = YES;
    self.serviceFilter = @"全部";
    self.areaFitler = @"全城市";
    self.sortFilter = @"默认排序";
}

- (void)configView {
    self.filterView = [[FilterView alloc] init];
    [self.filterView filterTypeDidSelected:^(FilterType filterType) {
        [self configSortView:filterType];
    }];
    [self.view addSubview:self.filterView];
    
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    MerchantTableViewController *merchantTVC = [[MerchantTableViewController alloc] init];
    merchantTVC.dataArr = self.dataArr;
    [self addChildViewController:merchantTVC];
    self.merchantTableView = merchantTVC.tableView;
    [self.view addSubview:self.merchantTableView];
    
    [self.merchantTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.filterView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //添加下拉刷新
    self.merchantTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

//实现父类的方法，为本类提供刷新数据方法
- (void)refresh {
    [self removeSortView];
    self.filterView.currentSelected.selected = NO;
    
    [self.merchantTableView.mj_header beginRefreshing];
}

#pragma mark - 排序视图
//展示排序视图
- (void)configSortView:(FilterType)filterType {
    [self removeSortView];
    
    if (filterType == FilterTypeNone) {
        return;
    }
    
    [self loadFilterData:filterType];

    self.sortTVC = [[SortTableViewController alloc] init];
    self.sortTVC.dataArr = self.sortArr;
    
    [self.sortTVC filterDidSelected:^(NSString *filter) {
        [self filterString:filter filterType:filterType];
        [self removeSortView];
        
        self.filterView.currentSelected.normalTitle = filter;
        self.filterView.currentSelected.selectedTitle = filter;

        [self refresh];
    }];
    
    [self addChildViewController:self.sortTVC];
    [self.view addSubview:self.sortTVC.tableView];
    
    [self.sortTVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.merchantTableView);
    }];
}

//移除排序视图
- (void)removeSortView {
    [self.sortTVC removeFromParentViewController];
    [self.sortTVC.tableView removeFromSuperview];
}

#pragma mark - 排序数据源
- (void)filterService {
    self.sortArr = [NSMutableArray arrayWithArray:@[@"全部",@"上牌",@"驾考",@"车险",@"检车",@"维修",@"租车",@"保养",@"二手车",@"车贷",@"新车",@"急救",@"用品",@"停车"]];
}

//当前城市各区数据列表
- (void)filterArea {
    NSString *currentCity = [self currentCity];
    NSString *currentProvince = [self currentProvince];
    AddressManager *manager = [AddressManager manager];
    NSArray *areaList = [manager areaListFromCity:currentCity province:currentProvince];
    self.sortArr = [NSMutableArray arrayWithArray:areaList];
    [self.sortArr insertObject:@"全城市" atIndex:0];
}

- (void)filterSort {
    self.sortArr = [NSMutableArray arrayWithArray:@[@"默认排序",@"离我最近",@"评价最高",@"最新发布",@"人气最高",@"价格最低",@"价格最高"]];
}


@end
