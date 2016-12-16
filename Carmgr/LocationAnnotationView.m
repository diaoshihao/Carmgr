//
//  LocationAnnotationView.m
//  Carmgr
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "LocationAnnotationView.h"

@implementation LocationAnnotationView

@synthesize rotateDegree = _rotateDegree;


-(void)setRotateDegree:(CGFloat)rotateDegree
{
    self.transform = CGAffineTransformMakeRotation(rotateDegree * M_PI / 180.f );
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
