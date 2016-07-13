//
//  AddCarInfoCell.h
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCarInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIView        *cusView;
@property (nonatomic, assign) NSIndexPath   *indexPath;

- (void)customView;

+ (NSString *)getReuseID;

@end
