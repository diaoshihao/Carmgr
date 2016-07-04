//
//  StoreViw.m
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StoreView.h"

@implementation StoreView

- (void)createHeadSortViewAtSuperView:(UIView *)superView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30)];
    backView.backgroundColor = [UIColor blueColor];
    [superView addSubview:backView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
