//
//  RateTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *user;
@property (nonatomic, strong) UILabel       *time;
@property (nonatomic, strong) UILabel       *text;

- (void)starViewWithStars:(NSString *)stars;

+ (NSString *)getReuseID;

@end
