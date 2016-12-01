//
//  CurrentCityTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"

typedef void(^buttonClickBlock)(UIButton *button);

typedef void(^hideAreaList)(void);

@interface CurrentCityTableViewCell : UITableViewCell

@property (nonatomic, copy) buttonClickBlock clickBlock;

@property (nonatomic, copy) hideAreaList hideBlcok;

@property (nonatomic, strong) UIButton *GPSButton;

@property (nonatomic, strong) LocationManager *locationManager;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)buttonDidClick:(UIButton *)sender;

@end
