//
//  ProgressTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *headImageView;

@property (nonatomic, strong) UILabel       *storeName;
@property (nonatomic, strong) UILabel       *serviceLabel;
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *stateLabel;

- (void)autoLayout;

+ (NSString *)getReuseID;

@end
