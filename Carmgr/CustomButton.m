//
//  GeneralButton.m
//  Carmgr
//
//  Created by admin on 2016/12/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    CustomButton *button = [super buttonWithType:buttonType];
    button.imagePosition = ImagePositionDefault;
    return button;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType imagePosition:(ImagePosition)position {
    CustomButton *button = [super buttonWithType:buttonType];
    button.imagePosition = position;
    return button;
}

//使用标题初始化
+ (instancetype)buttonWithTitle:(NSString *)title {
    CustomButton *button = [super buttonWithType:UIButtonTypeCustom];
    button.imagePosition = ImagePositionDefault;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

//使用图片初始化
+ (instancetype)buttonWithImage:(NSString *)imageName {
    CustomButton *button = [super buttonWithType:UIButtonTypeCustom];
    button.imagePosition = ImagePositionDefault;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

//圆形图片按钮
+ (instancetype)cycleImageButton:(NSString *)imageName {
    CustomButton *button = [super buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.clipsToBounds = YES;
    return button;
}

//设置颜色模式
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    UIImage *originImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [super setImage:originImage forState:state];
}

//正常标题
- (void)setNormalTitle:(NSString *)normalTitle {
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

//选中标题
- (void)setSelectedTitle:(NSString *)selectedTitle {
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

//正常颜色
- (void)setNormalImageName:(NSString *)normalImageName {
    [self setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
}

//选中图片
- (void)setSelectedImageName:(NSString *)selectedImageName {
    [self setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateNormal];
}

//正常颜色
- (void)setNormalColor:(UIColor *)normalColor {
    [self setTitleColor:normalColor forState:UIControlStateNormal];
}

//选中颜色
- (void)setSelectedColor:(UIColor *)selectedColor {
    [self setTitleColor:selectedColor forState:UIControlStateSelected];
}

- (void)imageUpper {
    self.imageView.contentMode = UIControlContentVerticalAlignmentCenter;
    
    CGRect newFrame = self.imageView.frame;
    // Center image
    newFrame.origin.x = self.frame.size.width / 2 - self.imageView.frame.size.width / 2;
    newFrame.origin.y = (self.frame.size.height - (self.imageView.frame.size.height + self.titleLabel.frame.size.height + 6)) / 2;
    
    self.imageView.frame = newFrame;
    
    newFrame = self.titleLabel.frame;
    //Center text
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height + 3;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)imageRight {
    self.imageView.contentMode = UIControlContentVerticalAlignmentCenter;
    
    //right image
    CGRect frame = self.imageView.frame;
    frame.origin.x = self.frame.size.width - self.imageView.frame.size.width + 5;
    self.imageView.frame = frame;
    
    //left text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    
    self.titleLabel.frame = newFrame;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imagePosition == ImagePositionDefault) {
        
    } else if (self.imagePosition == ImagePositionUpper) {
        [self imageUpper];
    } else if (self.imagePosition == ImagePositionRight) {
        [self imageRight];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
