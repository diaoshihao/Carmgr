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

+ (instancetype)buttonWithType:(UIButtonType)buttonType imagePosition:(ImagePosition)position;

+ (instancetype)cycleImageButton:(NSString *)imageName;

@end
