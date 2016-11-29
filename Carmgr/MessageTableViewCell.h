//
//  MessageTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

typedef void(^Click)();//点击查看详情的回调

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *photoView;

@property (nonatomic, strong) MessageModel *model;

@property (nonatomic, copy) Click click;

@end
