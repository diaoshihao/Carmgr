//
//  ViewController.h
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ShowView.h"
#import "YWDataBase.h"//数据库
#import "MJRefreshNormalHeader.h"

@class CustomButton;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *customBar;

@property (nonatomic, strong) CustomButton *cityChoose;

@property (nonatomic, strong) UISearchBar *searchBar;

- (void)createCustomBar;

- (void)refresh;

@end

