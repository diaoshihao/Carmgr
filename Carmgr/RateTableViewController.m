//
//  RateTableViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/29.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "RateTableViewController.h"
#import "RateTableViewCell.h"
#import "RateModel.h"

@interface RateTableViewController ()

@end

@implementation RateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[RateTableViewCell class] forCellReuseIdentifier:[RateTableViewCell getReuseID]];
    self.tableView.estimatedRowHeight = 105;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.bounces = NO;
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
    RateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RateTableViewCell getReuseID] forIndexPath:indexPath];
    
    RateModel *model = self.dataArr[indexPath.row];
    
    cell.headImageView.image = [UIImage imageNamed:@"评论头像"];
    
    cell.userNameLab.text = model.rate_user;
    cell.stars = model.rate_stars;
    cell.timeLab.text = [model.rate_time componentsSeparatedByString:@" "].firstObject;
    cell.rateLab.text = model.rate_text;
    
    if (indexPath.row == tableView.indexPathsForVisibleRows.lastObject.row) {
        
        [self tableViewContentHeight:indexPath tableView:tableView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//返回tableview的高度
- (void)tableViewContentHeight:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    self.contentHeight = 0;//set to 0 before change it
    
    //lookmore open
    //内容不超过十条显示所有内容大小，否则显示前十条内容大小，其他内容通过滑动查看
    if (self.lookMore) {
        if (indexPath.row <= 10) {
            self.contentHeight = tableView.contentSize.height;
            
        } else {
            NSArray *cells = tableView.visibleCells;
            
            for (NSInteger i = 0; i < 10; i++) {
                RateTableViewCell *cell = cells[i];
                self.contentHeight += [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            }
            
            //查看更多时超过10条内容后允许滑动
            tableView.scrollEnabled = YES;
        }
        
    //lookmore close
    } else {
        //内容不超过三条显示所有内容大小，否则显示前三条内容大小
        if (indexPath.row <= 3) {
            self.contentHeight = tableView.contentSize.height;
            
        } else {
            NSArray *cells = tableView.visibleCells;
            
            for (NSInteger i = 0; i < 3; i++) {
                RateTableViewCell *cell = cells[i];
                self.contentHeight += [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            }
        }
        
        //关闭查看更多时不可滑动
        tableView.scrollEnabled = NO;
    }
    
    if (self.contentBlock) {
        self.contentBlock(self.contentHeight);
    }
}

- (void)contentHeightReturn:(RateContentHeightBlock)contentBlock {
    self.contentBlock = contentBlock;
}


@end
