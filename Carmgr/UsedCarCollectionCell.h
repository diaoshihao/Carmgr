//
//  UsedCarCollectionCell.h
//  Carmgr
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsedCarCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

+ (NSString *)getReuseID;

@end
