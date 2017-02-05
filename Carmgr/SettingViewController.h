//
//  SettingViewController.h
//  Carmgr
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "SecondaryViewController.h"

typedef void(^LogoutBlock)(void);

@interface SettingViewController :SecondaryViewController

@property (nonatomic, copy) LogoutBlock logoutBlock;

- (void)userLogout:(LogoutBlock)logoutBlock;

@end
