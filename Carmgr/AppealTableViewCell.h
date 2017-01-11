//
//  AppealTableViewCell.h
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AppealAction) {
    AppealActionCancel,
    AppealActionEdit,
};

typedef void(^AppealActionBlock)(AppealAction action);

@interface AppealTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *appealImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, copy) AppealActionBlock appealBlock;

- (void)appealActionBegin:(AppealActionBlock)appealBlock;

+ (NSString *)getReuseID;

@end
