//
//  UIImage+CircleImage.m
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

+ (UIImage *)circleImage:(UIImage *)image borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    UIImage *oldImage = image;
    
    //开启上下文
    CGFloat imageWidth = oldImage.size.width + 2 * width;
    CGFloat imageHeight = oldImage.size.height + 2 * width;
    CGSize imageSize = CGSizeMake(imageWidth, imageHeight);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    //获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //画大圆边框
    [color set];
    CGFloat bigRadius = imageWidth * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(contextRef, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(contextRef);
    
    //画小圆
    CGFloat smallRadius = bigRadius - width;
    CGContextAddArc(contextRef, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    //切图
    CGContextClip(contextRef);
    
    //画图
    [oldImage drawInRect:CGRectMake(width, width, oldImage.size.width, oldImage.size.height)];
    
    //取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
