//
//  DetailServiceTableViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DetailServiceTableViewController.h"
#import "DetailServiceCell.h"
#import <UIImageView+WebCache.h>
#import "DefineValue.h"
#import "SubscribeViewController.h"

@interface DetailServiceTableViewController ()

@end

@implementation DetailServiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[DetailServiceCell class] forCellReuseIdentifier:[DetailServiceCell getReuseID]];
    self.tableView.rowHeight = 105;
    
    UILabel *headLable = [self titleLabel];
    headLable.frame = CGRectMake(0, 0, [DefineValue screenWidth], 44);
    self.tableView.tableHeaderView = headLable;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)titleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"可办业务";
    label.font = [DefineValue font14];
    label.textColor = [DefineValue mainColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 44, [DefineValue screenWidth], [DefineValue pixHeight] * 2)];
    separator.backgroundColor = [DefineValue separaColor];
    [label addSubview:separator];
    
    return label;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:[DetailServiceCell getReuseID] forIndexPath:indexPath];
    
    DetailServiceModel *model = self.dataArr[indexPath.row];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.service_img] placeholderImage:nil];
    cell.serviceName.text = model.service_name;
    cell.introduce.text = model.service_introduce;
    cell.stars = model.service_stars;
    cell.area.text = model.service_address;
    cell.road.text = model.service_address;
    cell.distance.text = model.service_distance;
    
    if (indexPath.row == tableView.indexPathsForVisibleRows.lastObject.row) {
        
        [self tableViewContentHeight:indexPath tableView:tableView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailServiceModel *model = self.dataArr[indexPath.row];
    if (self.subscribe) {
        self.subscribe(model);
    }
}

- (void)subscribeService_id:(SubscribeServiceBlock)subscribe {
    self.subscribe = subscribe;
}

//返回tableview的高度
- (void)tableViewContentHeight:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    //lookmore open
    //内容不超过十条显示所有内容大小，否则显示前十条内容大小，其他内容通过滑动查看
    if (self.lookMore) {
        if (indexPath.row <= 10) {
            self.contentHeight = tableView.contentSize.height;
        } else {
            self.contentHeight = 10 * 105 + 44;
            
            //查看更多时超过10条内容后允许滑动
            tableView.scrollEnabled = YES;
        }
        
    //lookmore close
    } else {
        //内容不超过三条显示所有内容大小，否则显示前三条内容大小
        if (indexPath.row <= 3) {
            self.contentHeight = tableView.contentSize.height;
        } else {
            self.contentHeight = 3 * 105 + 44;
        }
        
        //关闭查看更多时不可滑动
        tableView.scrollEnabled = NO;
    }
    
    if (self.contentBlock) {
        self.contentBlock(self.contentHeight);
    }
}

- (void)contentHeightReturn:(ServiceContentHeightBlock)contentBlock {
    self.contentBlock = contentBlock;
}

@end
