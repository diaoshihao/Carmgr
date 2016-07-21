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
@property (nonatomic, strong) UIView *sortView;

@end

@implementation YWStoreViewController

#pragma mark 跳转到个人中心(tabBar实例调用)
- (void)pushToUser:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[YWUserViewController alloc] init] animated:YES];
}

#pragma mark 选择城市
- (void)chooseCityAction:(UIButton *)sender {
    CityChooseViewController *cityChooseVC = [[CityChooseViewController alloc] init];
    [cityChooseVC returnCityInfo:^(NSString *province, NSString *area) {
        
        [[NSUserDefaults standardUserDefaults] setObject:area forKey:@"city"];
    }];
    [self.navigationController pushViewController:cityChooseVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.storeView = [[StoreView alloc] init];
    [self.storeView createHeadSortViewAtSuperView:self.view];
    [self.storeView createTableView:self.view];
    
    //添加下拉刷新
    self.storeView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.storeView.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    //参数
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *filter = [@"全部" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //先从数据库中取出缓存数据
    if ([[YWDataBase sharedDataBase] isExistsDataInTable:@"tb_store"]) {
        self.storeView.dataArr = [[YWDataBase sharedDataBase] getAllDataFromStore];
        [self.storeView.tableView reloadData];//刷新数据
    }
    
    [YWPublic afPOST:[NSString stringWithFormat:kSTORE,username,filter,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            [YWPublic showReLoginAlertViewAt:self];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求数据失败
        [self.storeView.tableView.mj_header endRefreshing];
        
        //关闭数据库
        [[YWDataBase sharedDataBase] closeDataBase];
        
        [YWPublic showFaileAlertViewAt:self];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    
    //获取并设置当前城市名
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    UIButton *cityButton = [self.navigationItem.leftBarButtonItem.customView.subviews firstObject];
    [cityButton setTitle:city forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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
