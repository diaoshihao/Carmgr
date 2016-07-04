//
//  HotTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *hotImageView;

+ (NSString *)getReuseID;

@end
