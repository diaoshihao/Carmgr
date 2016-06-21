//
//  YWPublic.m
//  Carmgr
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWPublic.h"

@implementation YWPublic

+ (UIView *)createCustomNavigationBarWithFrame:(CGRect)frame
                                         title:(NSString *)title
                                     imageName:(NSString *)imageName {
    
    UIView *customView = [[UIView alloc] initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 24, 24)];
    imageView.image = [UIImage imageNamed:imageName];
    [customView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 80, 24)];
    label.text = title;
    [customView addSubview:label];
    return customView;
}

@end
