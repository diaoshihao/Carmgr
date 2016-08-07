//
//  StoreTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UILabel       *storeName;
@property (nonatomic, strong) UILabel       *introduce;
@property (nonatomic, strong) UILabel       *area;
@property (nonatomic, strong) UILabel       *road;
@property (nonatomic, strong) UILabel       *distance;

@property (nonatomic, strong) NSString      *stars;

- (void)starView;

+ (NSString *)getReuseID;

@end
