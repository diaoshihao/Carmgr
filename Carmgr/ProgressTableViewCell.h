//
//  ProgressTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderView.h"

@interface ProgressTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *headImageView;

@property (nonatomic, strong) UILabel       *storeName;
@property (nonatomic, strong) UILabel       *serviceLabel;
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *stateLabel;
@property (nonatomic, strong) UILabel       *costLabel;

@property (nonatomic, strong) UIButton      *button1;
@property (nonatomic, strong) UIButton      *button2;


- (void)OrderState:(OrderProgress)progress;

+ (NSString *)getReuseID;



@end
