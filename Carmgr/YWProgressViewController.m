//
//  YWProgressViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWProgressViewController.h"
#import "ProgressTableViewController.h"
#import "ProgressModel.h"
#import "MyProgressView.h"
#import "Interface.h"
#import "MJRefresh.h"
#import <Masonry.h>

@interface YWProgressViewController ()


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) MyProgressView *myProgressView;

@end

@implementation YWProgressViewController
{
    ProgressTableViewController *_progressTVC;
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    
    [self showPage];
    [self refresh];
}

- (void)showPage {
    [self config];
    [self configView];
}

- (void)config {
    self.title = @"订单";
    
    _progressTVC = [[ProgressTableViewController alloc] init];
    _progressTVC.dataArr = self.dataArr;
    [self addChildViewController:_progressTVC];
    self.tableView = _progressTVC.tableView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)configView {
    self.myProgressView = [[MyProgressView alloc] init];
    self.currentFilter = self.myProgressView.currentSelected.currentTitle;
    [self.myProgressView selectedCurrentState:^(OrderProgress progress) {
        //设置当前筛选条件
        self.currentFilter = self.myProgressView.titles[progress];
        [self.tableView.mj_header beginRefreshing];
    }];
    [self.view addSubview:self.myProgressView];
    [self.myProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myProgressView.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

//实现父类的方法，为本类提供刷新数据方法
- (void)refresh {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark 加载网络数据
- (void)loadData {
    NSArray *progress = [Interface appgetprocess_filter:self.currentFilter];
    [MyNetworker POST:progress[InterfaceUrl] parameters:progress[Parameters] success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self.dataArr removeAllObjects];
            for (NSDictionary *dict in responseObject[@"orders_list"]) {
                ProgressModel *model = [[ProgressModel alloc] initWithDict:dict];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)showAlertView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂未能获取到您的订单信息" preferredStyle:UIAlertControllerStyleAlert];
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
