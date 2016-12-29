//
//  MerchantTableViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MerchantTableViewController.h"
#import "MerchantTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DetailViewController.h"

@interface MerchantTableViewController ()

@end

@implementation MerchantTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 105;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[MerchantTableViewCell class] forCellReuseIdentifier:[MerchantTableViewCell getReuseID]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MerchantTableViewCell getReuseID] forIndexPath:indexPath];
    
    MerchantModel *model = self.dataArr[indexPath.row];
    
    //异步加载图片
    [cell.merchantImageView sd_setImageWithURL:[NSURL URLWithString:model.img_path]];
    
    cell.merchantName.text = model.merchant_name;
    cell.introduce.text = model.merchant_introduce;
    cell.stars = model.stars;
    cell.area.text = model.area;
    cell.road.text = model.road;
    cell.distance.text = model.distance;
    
    [cell starView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantModel *model = self.dataArr[indexPath.row];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.merchant_name = model.merchant_name;
    detailVC.address = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.road];
    detailVC.stars = model.stars;
    
    //跳转到详情页
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
}

@end
