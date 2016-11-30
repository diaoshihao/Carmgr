//
//  RightImageButton.m
//  Carmgr
//
//  Created by admin on 2016/11/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "RightImageButton.h"

@implementation RightImageButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
