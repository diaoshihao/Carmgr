//
//  CycleScrollView.m
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CycleScrollView.h"
#import <SDCycleScrollView.h>
#import "DefineValue.h"
#import <Masonry.h>

@interface CycleScrollView()

@end

@implementation CycleScrollView

- (void)setAutoScroll:(BOOL)autoScroll {
    if (autoScroll == YES) {
        [self autoScrollView];
    } else {
        [self manualScrollView];
    }
}

- (void)setImages:(NSArray<NSString *> *)images {
    _images = images;
    [self configViews];
}

- (void)configViews {
    for (NSInteger i = 0; i < self.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([DefineValue screenWidth] * i, 0, [DefineValue screenWidth], [DefineValue screenWidth] * 300 / 720)];
        if ([self.images[i] hasPrefix:@"http"]) {
            imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.images[i]]]];
        } else {
            imageView.image = [UIImage imageNamed:self.images[i]];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
    self.contentSize = CGSizeMake([DefineValue screenWidth] * self.images.count, 0);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)imageViewDidTap:(ImageTap)imageTap {
    NSUInteger index = self.contentOffset.x / [DefineValue screenWidth];
    imageTap(index);
}

- (void)autoScrollView {
    
}

- (void)manualScrollView {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
