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

+ (instancetype)cycleImageButton:(NSString *)imageName {
    CustomButton *button = [super buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    button.layer.cornerRadius = button.frame.size.height / 2;
    button.clipsToBounds = YES;
    return button;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    UIImage *originImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [super setImage:originImage forState:state];
}

- (void)imageUpper {
    self.imageView.contentMode = UIControlContentVerticalAlignmentCenter;
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = (self.frame.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height - 5);
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height + 5;
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
