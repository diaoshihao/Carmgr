//
//  UIButton+SetEdges.m
//  Carmgr
//
//  Created by admin on 2016/11/25.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UIButton+SetEdges.h"

@implementation UIButton (SetEdges)

- (void)setUpperImage {
    CGFloat imageWidth = self.imageView.bounds.size.width;
    CGFloat imageHeight = self.imageView.bounds.size.height;
    CGFloat titleWidth = self.titleLabel.bounds.size.width;
    CGFloat titleHeight = self.titleLabel.bounds.size.height;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.5*imageHeight+10, -0.5*imageWidth, -0.5*imageHeight-10, 0.5*imageWidth)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-0.5*titleHeight-10, 0.5*titleWidth, 0.5*titleHeight+10, -0.5*titleWidth)];
}

- (void)setRightImage {
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.intrinsicContentSize.width, 0, self.imageView.intrinsicContentSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.intrinsicContentSize.width, 0, -self.titleLabel.intrinsicContentSize.width)];
}

@end
