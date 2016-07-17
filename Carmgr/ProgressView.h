//
//  ProgressView.h
//  Carmgr
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIViewController  *actionTarget;

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) NSMutableArray    *dataArr;


- (UITableView *)createTableView:(UIView *)superView;

@end
