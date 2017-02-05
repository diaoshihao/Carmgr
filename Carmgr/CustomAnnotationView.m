//
//  CustomAnnotationView.m
//  Carmgr
//
//  Created by admin on 2017/1/6.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "DefineValue.h"
#import <Masonry.h>
#import "CircleImageView.h"

@interface CustomAnnotationView()

@property (nonatomic, strong) UIImageView *background;

@end

@implementation CustomAnnotationView
{
    CircleImageView *_imageView;
    UIImage *_merchantImg;
}

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)setMerchantImg:(UIImage *)merchantImg {
    if (_merchantImg != merchantImg) {
        _merchantImg = merchantImg;
    }
    _imageView.image = self.merchantImg == nil ? [UIImage imageNamed:@"icon"] : self.merchantImg;
}

- (UIImage *)merchantImg {
    return _merchantImg;
}

- (void)configView {
    self.background = [[UIImageView alloc] init];
    self.background.image = [UIImage imageNamed:@"标注白"];
    self.background.layer.masksToBounds = YES;
    [self addSubview:self.background];
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _imageView = [[CircleImageView alloc] init];
    [self.background addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self.background);
        make.width.mas_equalTo(self.background.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(self.background.mas_height).multipliedBy(0.7);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return;
    }
    
    if (selected) {
        self.background.image = [UIImage imageNamed:@"标注橙"];
        CGRect frame = self.frame;
        frame.size = CGSizeMake(60, 60);
        [UIView animateWithDuration:0.618 animations:^{
            self.frame = frame;
        }];
        
    } else {
        self.background.image = [UIImage imageNamed:@"标注白"];
        CGRect frame = self.frame;
        frame.size = CGSizeMake(48, 48);
        [UIView animateWithDuration:0.618 animations:^{
            self.frame = frame;
        }];
    }
    
    
    
    [super setSelected:selected animated:animated];
    
}

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    [super willMoveToSuperview:newSuperview];
//    
//    if (newSuperview == nil) {
//        return;
//    }
//    
//    if (CGRectContainsPoint(newSuperview.bounds, self.center)) {
//        CABasicAnimation *growAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        growAnimation.delegate = (id<CAAnimationDelegate>)self;
//        growAnimation.duration = 0.618f;
//        growAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        
//        growAnimation.fromValue = [NSNumber numberWithDouble:0.0f];
//        
//        growAnimation.toValue = [NSNumber numberWithDouble:1.0f];
//        
//        [self.layer addAnimation:growAnimation forKey:@"growAnimation"];
//    }
//}

@end
