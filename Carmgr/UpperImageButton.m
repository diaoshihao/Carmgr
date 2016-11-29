//
//  UpperImageButton.m
//  Carmgr
//
//  Created by admin on 2016/11/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UpperImageButton.h"

@implementation UpperImageButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
