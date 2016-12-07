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
#import <UIImageView+WebCache.h>
#import "MJRefreshNormalHeader.h"
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

//- (UIBarButtonItem *)createBarButtonItem:(CGRect)frame {
//    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    barButton.frame = frame;
//    [barButton setImage:[UIImage imageNamed:@"后退橙"] forState:UIControlStateNormal];
//    barButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [barButton addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
//    barButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    return item;
//}

//- (void)turnBack {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.service_filter;
    
//    self.navigationItem.leftBarButtonItem = [self createBarButtonItem:CGRectMake(0, 0, 60, 40)];
    
    [self createTableView];
    
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = NO;
//}

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
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    
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
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *city_filter = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    NSString *service_filter = self.service_filter;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSString *urlStr = [[NSString stringWithFormat:kSTORE,username,city_filter,service_filter,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //停止刷新
        [self.tableView.mj_header endRefreshing];
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *dict in dataDict[@"merchants_list"]) {
                
                StoreModel *model = [[StoreModel alloc] initWithDict:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];//刷新数据
            if (self.dataArray.count == 0) {
                [self showAlertView];
            }
            
        } else {
            [YWPublic pushToLogin:self];
            /*
             UIAlertController *alertVC = [YWPublic showReLoginAlertViewAt:self];
             [self presentViewController:alertVC animated:YES completion:nil];
             */
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
