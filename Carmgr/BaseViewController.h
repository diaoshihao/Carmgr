//
//  ViewController.h
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPublic.h"
@class RightImageButton;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *customBar;

@property (nonatomic, strong) RightImageButton *cityChoose;

@property (nonatomic, strong) UISearchBar *searchBar;

- (void)createCustomBar;

- (void)refresh;

@end

