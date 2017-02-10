//
//  RateTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarsView.h"
#import "CustomLabel.h"

@interface RateTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *userNameLab;
@property (nonatomic, strong) UILabel       *timeLab;
@property (nonatomic, strong) CustomLabel   *rateLab;
@property (nonatomic, strong) StarsView     *starsView;

@property (nonatomic, strong) NSString      *stars;


+ (NSString *)getReuseID;

@end
