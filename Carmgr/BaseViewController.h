//
//  ViewController.h
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPublic.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *customBar;

@property (nonatomic, strong) UIButton *cityChoose;

@property (nonatomic, strong) UISearchBar *searchBar;

- (void)createCustomBar;

@end

