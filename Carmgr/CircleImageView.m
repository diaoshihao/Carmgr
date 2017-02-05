//
//  CycleImageView.m
//  Carmgr
//
//  Created by admin on 2017/1/18.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CircleImageView.h"

@implementation CircleImageView

- (void)layoutSubviews {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
