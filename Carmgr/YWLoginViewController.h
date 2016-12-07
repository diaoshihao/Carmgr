//
//  YWLoginViewController.h
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface YWLoginViewController : UIViewController

@property (nonatomic) BOOL isFromHome;

@property (nonatomic, strong) BaseViewController *fromVC;

@property (nonatomic, assign) BOOL cancelBtnHidden;

@end
