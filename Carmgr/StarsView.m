//
//  StarsView.m
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StarsView.h"
#import <Masonry.h>

@implementation StarsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setStars:(NSString *)stars {
    _stars = stars;
    [self removeAllSubviews];
    [self configView];
}

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)configView {
    CGFloat floatVal = [self.stars floatValue];
    NSInteger intVal = [self.stars intValue];
    
    UIImageView *lastImage = nil;
    
    //分数取整数，创建整数个星星
    for (NSInteger i = 0; i < intVal; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        if (self.bigStar) {
            starImage.image = [UIImage imageNamed:@"大星星"];
        } else {
            starImage.image = [UIImage imageNamed:@"星星"];
        }
        starImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            if (i == 0) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            }
        }];
        
        lastImage = starImage;
    }
    
    //如果是x.5分，最后增加半个星星
    if (floatVal > intVal) {
        UIImageView *halfStarImage = [[UIImageView alloc] init];
        if (self.bigStar) {
            halfStarImage.image = [UIImage imageNamed:@"大半星"];
        } else {
            halfStarImage.image = [UIImage imageNamed:@"半星"];
        }
        halfStarImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self addSubview:halfStarImage];
        
        [halfStarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            make.centerY.mas_equalTo(lastImage);
        }];
        
        lastImage = halfStarImage;
    }
    
    [lastImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
