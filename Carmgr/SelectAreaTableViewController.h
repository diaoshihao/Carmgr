//
//  SelectAreaTableViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectAreaTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *selectedArea;

@property (nonatomic, strong) UIButton *sureButton;


@end
