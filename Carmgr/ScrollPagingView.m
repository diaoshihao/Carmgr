//
//  ScrollPagingView.m
//  Carmgr
//
//  Created by admin on 2017/1/3.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "ScrollPagingView.h"

@interface ScrollPagingView() <UIScrollViewDelegate>

@end

@implementation ScrollPagingView

- (instancetype)initWithItemSpace:(CGFloat)itemSpace viewObjs:(NSArray *)viewObjs {
    self = [super init];
    if (self) {
        self.itemSpace = itemSpace;
        self.viewObjs = viewObjs;
        [self setup];
        [self configView];
    }
    return self;
}

- (void)setup {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollsToTop = NO;
    self.delegate = self;
}

- (void)configView {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
