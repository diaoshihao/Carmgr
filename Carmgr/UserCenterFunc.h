//
//  UserCenterFunc.h
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserCenterFunc : NSObject

@property (nonatomic, strong) UIImageView   *userImageView;
@property (nonatomic, strong) UIButton      *userName;

@property (nonatomic, strong) UIViewController *actionTarget;

- (UITableView *)createTableView:(UIView *)superView;

@end
