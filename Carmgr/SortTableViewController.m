//
//  SortTableViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "SortTableViewController.h"

@interface SortTableViewController ()

@end

@implementation SortTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sorttableviewcell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sorttableviewcell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.filterBlock) {
        self.filterBlock(self.dataArr[indexPath.row]);
    }
}

- (void)filterDidSelected:(FilterSelectBlock)filterBlock {
    self.filterBlock = filterBlock;
}

@end
