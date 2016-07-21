//
//  UserInfoCell.h
//  Carmgr
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *label;
@property (nonatomic, strong) UIImageView   *headImageView;

- (void)customViewAtRow:(NSInteger)row;

+ (NSString *)getReuseID;

@end
