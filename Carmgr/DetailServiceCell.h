//
//  DetailServiceCell.h
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarsView.h"

@interface DetailServiceCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *serviceName;
@property (nonatomic, strong) UILabel       *introduce;
@property (nonatomic, strong) UILabel       *area;
@property (nonatomic, strong) UILabel       *road;
@property (nonatomic, strong) UILabel       *distance;
@property (nonatomic, strong) StarsView     *starsView;

@property (nonatomic, strong) NSString      *stars;

+ (NSString *)getReuseID;

@end
