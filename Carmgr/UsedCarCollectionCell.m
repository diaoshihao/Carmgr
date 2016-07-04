//
//  UsedCarCollectionCell.m
//  Carmgr
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UsedCarCollectionCell.h"

@implementation UsedCarCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //注意self.frame 和 self.bounds，是个大坑!
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}

+ (NSString *)getReuseID {
    return @"usedcarcell";
}

@end
