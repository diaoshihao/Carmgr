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

#import "RateListViewController.h"

@interface RateTableViewController ()

@end

@implementation RateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    return self.dataArr.count == 0 ? 1 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44;
    } else {
        RateTableViewCell *cell = [[RateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rate"];
        return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (self.dataArr.count != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"用户评论(%ld)",self.dataArr.count];
        
        return cell;
        
    } else {
        
        RateTableViewCell *cell = [[RateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rate"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        RateModel *model = self.dataArr.firstObject;
        cell.headImageView.image = [UIImage imageNamed:@"评论头像"];
        
        cell.userNameLab.text = model.rate_user;
        cell.stars = model.rate_stars;
        cell.timeLab.text = [model.rate_time componentsSeparatedByString:@" "].firstObject;
        cell.rateLab.text = model.rate_text;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && self.dataArr.count != 0) {
        RateListViewController *rateListVC = [[RateListViewController alloc] init];
        rateListVC.dataArr = self.dataArr;
        [self.parentViewController.navigationController pushViewController:rateListVC animated:YES];
    }
    
}

//返回tableview的高度
//- (void)tableViewContentHeight:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
//    self.contentHeight = 0;//set to 0 before change it
//    
//    //lookmore open
//    //内容不超过十条显示所有内容大小，否则显示前十条内容大小，其他内容通过滑动查看
//    if (self.lookMore) {
//        if (indexPath.row <= 10) {
//            self.contentHeight = tableView.contentSize.height;
//            
//        } else {
//            NSArray *cells = tableView.visibleCells;
//            
//            for (NSInteger i = 0; i < 10; i++) {
//                RateTableViewCell *cell = cells[i];
//                self.contentHeight += [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//            }
//            
//            //查看更多时超过10条内容后允许滑动
//            tableView.scrollEnabled = YES;
//        }
//        
//    //lookmore close
//    } else {
//        //内容不超过三条显示所有内容大小，否则显示前三条内容大小
//        if (indexPath.row <= 3) {
//            self.contentHeight = tableView.contentSize.height;
//            
//        } else {
//            NSArray *cells = tableView.visibleCells;
//            
//            for (NSInteger i = 0; i < 3; i++) {
//                RateTableViewCell *cell = cells[i];
//                self.contentHeight += [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//            }
//        }
//        
//        //关闭查看更多时不可滑动
//        tableView.scrollEnabled = NO;
//    }
//    
//    if (self.contentBlock) {
//        self.contentBlock(self.contentHeight);
//    }
//}

//- (void)contentHeightReturn:(RateContentHeightBlock)contentBlock {
//    self.contentBlock = contentBlock;
//}


@end
