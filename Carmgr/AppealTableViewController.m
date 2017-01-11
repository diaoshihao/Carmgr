//
//  AppealTableViewController.m
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "AppealTableViewController.h"
#import "AppealTableViewCell.h"
#import "AppealModel.h"

@interface AppealTableViewController ()

@end

@implementation AppealTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[AppealTableViewCell class] forCellReuseIdentifier:[AppealTableViewCell getReuseID]];
    self.tableView.tableFooterView = [[UIView alloc] init];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AppealTableViewCell getReuseID] forIndexPath:indexPath];
    
    
    
    return cell;
}

@end
