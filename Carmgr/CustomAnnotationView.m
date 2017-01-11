//
//  CustomAnnotationView.m
//  Carmgr
//
//  Created by admin on 2017/1/6.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "DefineValue.h"

@implementation CustomAnnotationView
{
    UIImageView *_imageView;
    UIImage *_merchantImg;
    CGRect _originFrame;
}

- (void)setMerchantImg:(UIImage *)merchantImg {
    if (_merchantImg != merchantImg) {
        _merchantImg = merchantImg;
    }
    [self addImage];
}

- (UIImage *)merchantImg {
    return _merchantImg;
}

- (void)addImage {
    _originFrame = self.frame;
    _imageView = [[UIImageView alloc] initWithFrame:self.frame];
    _imageView.image = self.merchantImg == nil ? [UIImage imageNamed:@"icon"] : self.merchantImg;
    _imageView.layer.cornerRadius = _imageView.frame.size.width / 2;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _imageView.layer.borderWidth = 2;
    [self addSubview:_imageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return;
    }
    
    if (selected) {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(48, 48);
        self.frame = frame;
        
        [UIView animateWithDuration:0.618 animations:^{
            _imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            _imageView.layer.borderColor = [DefineValue mainColor].CGColor;
        }];
        
    } else {
        CGRect frame = self.frame;
        frame.size = _originFrame.size;
        self.frame = frame;
        
        [UIView animateWithDuration:0.618 animations:^{
            _imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
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
