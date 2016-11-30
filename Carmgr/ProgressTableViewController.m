//
//  ProgressTableViewController.m
//  Carmgr
//
//  Created by admin on 2016/11/29.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ProgressTableViewController.h"
#import "ProgressTableViewCell.h"
#import "ProgressModel.h"
#import "YWPublic.h"

@interface ProgressTableViewController ()

@end

@implementation ProgressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = [UIScreen mainScreen].bounds.size.height/6;
    
    [self.tableView registerClass:[ProgressTableViewCell class] forCellReuseIdentifier:[ProgressTableViewCell getReuseID]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4.99;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProgressTableViewCell getReuseID] forIndexPath:indexPath];
    
    ProgressModel *model = self.dataArr[indexPath.section];
    [YWPublic loadWebImage:model.img_path didLoad:^(UIImage * _Nonnull image) {
        cell.headImageView.image = image;
    }];
    cell.storeName.text = model.merchant_name;
    cell.serviceLabel.text = model.service_name;
    cell.numberLabel.text = model.order_id;
    cell.timeLabel.text = model.order_time;
    //OrderProgress 1-6 is order_state0-5 so + 1
    OrderProgress progress = [model.order_state integerValue] + 1;
    [cell OrderState:progress];
    
//    [cell.button1 setTitle:@"取消订单" forState:UIControlStateNormal];
//    [cell.button2 setTitle:@"催进度" forState:UIControlStateNormal];
    
    return cell;
}



@end
