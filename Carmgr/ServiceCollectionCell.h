//
//  ServiceCollectionCell.h
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

+ (NSString *)getCellID;

@end
