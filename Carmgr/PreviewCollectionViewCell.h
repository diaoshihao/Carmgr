//
//  PreviewCollectionViewCell.h
//  Carmgr
//
//  Created by admin on 2016/12/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineValue.h"
#import <Masonry.h>

@interface PreviewCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void (^singleTapGestureBlock)();

- (void)recoverSubviews;

@end
