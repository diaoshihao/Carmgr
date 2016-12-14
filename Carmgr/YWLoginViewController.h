//
//  YWLoginViewController.h
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "BasicViewController.h"
#import "BaseViewController.h"

@interface YWLoginViewController : BasicViewController

@property (nonatomic) BOOL isFromHome;

@property (nonatomic, strong) BaseViewController *fromVC;

@property (nonatomic, assign) BOOL cancelBtnHidden;

@end
