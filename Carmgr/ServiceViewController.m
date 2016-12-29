//
//  ServiceViewController.m
//  Carmgr
//
//  Created by admin on 16/8/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceViewController.h"
#import "MerchantModel.h"
#import "UIViewController+ShowView.h"
#import "MJRefreshNormalHeader.h"
#import "Interface.h"
#import "YWPublic.h"
#import "DetailViewController.h"
#import "MerchantTableViewController.h"

@interface ServiceViewController ()

@property (nonatomic, strong) UITableView *merchantTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ServiceViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.service_filter;
    self.showShadow = YES;
    
    [self configView];
    [self refresh];
}

- (void)configView {
    
    MerchantTableViewController *merchantTVC = [[MerchantTableViewController alloc] init];
    merchantTVC.dataArr = self.dataArray;
    [self addChildViewController:merchantTVC];
    self.merchantTableView = merchantTVC.tableView;
    [self.view addSubview:self.merchantTableView];
    
    [self.merchantTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //添加下拉刷新
    self.merchantTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

//实现父类的方法，为本类提供刷新数据方法
- (void)refresh {
    [self.merchantTableView.mj_header beginRefreshing];
}

- (void)loadData {
    //参数
    NSString *city_filter = [self currentCity];
    NSString *service_filter = self.service_filter;
    
    NSArray *merchants = [Interface appgetmerchantslist_city_filter:city_filter service_filter:service_filter];
    [MyNetworker POST:merchants[InterfaceUrl] parameters:merchants[Parameters] success:^(id responseObject) {
        //停止刷新
        [self.merchantTableView.mj_header endRefreshing];
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *dict in responseObject[@"merchants_list"]) {
                
                MerchantModel *model = [[MerchantModel alloc] initWithDict:dict];
                [self.dataArray addObject:model];
            }
            [self.merchantTableView reloadData];//刷新数据
            if (self.dataArray.count == 0) {
                [self showAlertView];
            }
        } else {
        }
    } failure:^(NSError *error) {
        //请求数据失败
        [self.merchantTableView.mj_header endRefreshing];
        
        UIAlertController *alertVC = [YWPublic showFaileAlertViewAt:self];
        [self presentViewController:alertVC animated:YES completion:nil];
    }];
    
}

- (void)showAlertView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无相关数据" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
