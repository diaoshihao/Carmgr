//
//  SortTableViewController.h
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FilterSelectBlock)(NSString *filter);

@interface SortTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, copy) FilterSelectBlock filterBlock;

- (void)filterDidSelected:(FilterSelectBlock)filterBlock;

@end
