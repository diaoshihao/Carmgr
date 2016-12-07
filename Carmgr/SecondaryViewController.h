//
//  SecondaryViewController.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

/**
 * 二级页面的基类
 */

#import "BasicViewController.h"

@interface SecondaryViewController : BasicViewController

@property (nonatomic, assign) BOOL showShadow;

- (void)configRightItemView;

@end
