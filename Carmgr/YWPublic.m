//
//  YWPublic.m
//  Carmgr
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWPublic.h"

@implementation YWPublic

//创建Button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (imageName != nil) {
        [button setImage:[YWPublic imageNameWithOriginalRender:imageName] forState:UIControlStateNormal];
    }
    
    return button;
}

//图片渲染模式
+ (UIImage *)imageNameWithOriginalRender:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

/**
 *  创建圆形图片
 */
+ (UIImageView *)createCycleImageViewWithFrame:(CGRect)frame image:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    imageView.clipsToBounds = YES;
    return imageView;
}

@end
