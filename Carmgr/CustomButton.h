//
//  GeneralButton.h
//  Carmgr
//
//  Created by admin on 2016/12/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImagePosition) {
    ImagePositionDefault,
    ImagePositionUpper,
    ImagePositionRight,
};

@interface CustomButton : UIButton

@property (nonatomic, assign) ImagePosition imagePosition;

@property (nonatomic, strong) NSString *normalTitle;

@property (nonatomic, strong) NSString *selectedTitle;

@property (nonatomic, strong) NSString *normalImageName;

@property (nonatomic, strong) NSString *selectedImageName;

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIColor *selectedColor;

+ (instancetype)buttonWithType:(UIButtonType)buttonType imagePosition:(ImagePosition)position;

//圆形图片按钮
+ (instancetype)cycleImageButton:(NSString *)imageName;

//使用标题初始化
+ (instancetype)buttonWithTitle:(NSString *)title;

//使用图片初始化
+ (instancetype)buttonWithImage:(NSString *)imageName;

@end
