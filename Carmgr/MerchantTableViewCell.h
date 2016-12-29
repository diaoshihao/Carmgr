//
//  MerchantTableViewCell.h
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *merchantImageView;
@property (nonatomic, strong) UILabel       *merchantName;
@property (nonatomic, strong) UILabel       *introduce;
@property (nonatomic, strong) UILabel       *area;
@property (nonatomic, strong) UILabel       *road;
@property (nonatomic, strong) UILabel       *distance;

@property (nonatomic, strong) NSString      *stars;

- (void)starView;

+ (NSString *)getReuseID;

@end
