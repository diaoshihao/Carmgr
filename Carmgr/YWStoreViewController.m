//
//  YWStoreViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWStoreViewController.h"
#import "YWUserViewController.h"
#import "ScanImageViewController.h"
#import "YWPublic.h"
#import "StoreView.h"
#import <Masonry.h>
#import "StoreModel.h"

@interface YWStoreViewController () 

@property (nonatomic, strong) StoreView *storeView;

@end

@implementation YWStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.storeView = [[StoreView alloc] init];
    self.storeView.VC = self;
    [self.storeView createHeadSortViewAtSuperView:self.view];
    [self.storeView createTableView:self.view];
    
    //添加下拉刷新
    self.storeView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self refresh];
}

//实现父类的方法，为本类提供刷新数据方法
- (void)refresh {
    [self.storeView.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    //参数
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *city_filter = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    if (self.storeView.service_filter == nil) {
        self.storeView.service_filter = @"全部";
    }
    NSString *service_filter = self.storeView.service_filter;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    //先从数据库中取出缓存数据
    if ([[YWDataBase sharedDataBase] isExistsDataInTable:@"tb_store"]) {
        self.storeView.dataArr = [[YWDataBase sharedDataBase] getAllDataFromStore];
        [self.storeView.tableView reloadData];//刷新数据
    }
    
    NSString *urlStr = [[NSString stringWithFormat:kSTORE,username,city_filter,service_filter,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //停止刷新
        [self.storeView.tableView.mj_header endRefreshing];
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            
            //插入数据库前删除数据
            [[YWDataBase sharedDataBase] deleteDatabaseFromTable:@"tb_store"];
            [self.storeView.dataArr removeAllObjects];
            
            for (NSDictionary *dict in dataDict[@"merchants_list"]) {
                
                StoreModel *model = [[StoreModel alloc] initWithDict:dict];
                [self.storeView.dataArr addObject:model];
                
                
                //插入数据库
                [[YWDataBase sharedDataBase] insertStoreWithModel:model];
            }
            [self.storeView.tableView reloadData];//刷新数据
            
        } else {
            [YWPublic pushToLogin:self];
            /*
            UIAlertController *alertVC = [YWPublic showReLoginAlertViewAt:self];
            [self presentViewController:alertVC animated:YES completion:nil];
             */
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求数据失败
        [self.storeView.tableView.mj_header endRefreshing];
        
        UIAlertController *alertVC = [YWPublic showFaileAlertViewAt:self];
        [self presentViewController:alertVC animated:YES completion:nil];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.storeView.sortTableView != nil) {
        [self.storeView.sortTableView removeFromSuperview];
        self.storeView.sortkey = SortByNone;
        //还原按钮颜色
        for (NSInteger i = 1; i <= 3; i++) {
            UIButton *button = [self.view viewWithTag:i * 100];
            [button setTitleColor:[UIColor colorWithRed:45/256.0 green:45/256.0 blue:45/256.0 alpha:1] forState:UIControlStateNormal];
            UIImageView *imageView = [self.view viewWithTag:button.tag * 10];
            imageView.highlighted = NO;
        }
    }
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
