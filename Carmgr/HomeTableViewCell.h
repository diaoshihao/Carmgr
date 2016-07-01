//
//  HomeTableViewCell.h
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UICollectionView *collectionView;

+ (NSString *)reuseID;

@end
