//
//  SearchResultTableViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showAreaList)(UIView *view, NSString *city);

@interface SearchResultTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic, copy) showAreaList showBlock;

@end
