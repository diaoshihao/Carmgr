//
//  ServiceViewController.m
//  Carmgr
//
//  Created by admin on 16/8/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceViewController.h"
#import "StoreTableViewCell.h"
#import "StoreModel.h"
#import "UIViewController+ShowView.h"
#import "MJRefreshNormalHeader.h"
#import "Interface.h"
#import "YWPublic.h"
#import "StoreDetailViewController.h"

@interface ServiceViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

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
    
    [self createTableView];
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 105;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[StoreTableViewCell class] forCellReuseIdentifier:[StoreTableViewCell getReuseID]];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[StoreTableViewCell getReuseID] forIndexPath:indexPath];
    
    StoreModel *model = self.dataArray[indexPath.row];
    
    [YWPublic loadWebImage:model.img_path didLoad:^(UIImage * _Nonnull image) {
        cell.headImageView.image = image;
    }];
    
    cell.storeName.text = model.merchant_name;
    cell.introduce.text = model.merchant_introduce;
    cell.stars = model.stars;
    cell.area.text = model.area;
    cell.road.text = model.road;
    cell.distance.text = model.distance;
    
    [cell starView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StoreDetailViewController *storeDetailVC = [[StoreDetailViewController alloc] init];
    
    StoreModel *model = self.dataArray[indexPath.row];
    storeDetailVC.storeModel = model;
    
    //跳转到详情页
    storeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeDetailVC animated:YES];
    
}

- (void)loadData {
    //参数
    NSString *city_filter = [self currentCity];
    NSString *service_filter = self.service_filter;
    
    NSArray *merchants = [Interface appgetmerchantslist_city_filter:city_filter service_filter:service_filter];
    [MyNetworker POST:merchants[InterfaceUrl] parameters:merchants[Parameters] success:^(id responseObject) {
        //停止刷新
        [self.tableView.mj_header endRefreshing];
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *dict in responseObject[@"merchants_list"]) {
                
                StoreModel *model = [[StoreModel alloc] initWithDict:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];//刷新数据
            if (self.dataArray.count == 0) {
                [self showAlertView];
            }
        } else {
        }
    } failure:^(NSError *error) {
        //请求数据失败
        [self.tableView.mj_header endRefreshing];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
