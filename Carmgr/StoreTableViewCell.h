//
//  StoreTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel     *storeName;
@property (nonatomic, strong) UILabel     *address;
@property (nonatomic, strong) UILabel     *score;

@property (nonatomic, strong) NSArray     *model;

+ (NSString *)getReuseID;

@end
