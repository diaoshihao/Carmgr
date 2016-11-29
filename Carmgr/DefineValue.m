//
//  DefineValue.m
//  Carmgr
//
//  Created by admin on 2016/11/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DefineValue.h"

@implementation DefineValue

+ (UIColor *)mainColor {
    return [UIColor colorWithRed:255/255.0 green:167/255.0 blue:0 alpha:1];
}

+ (UIColor *)separaColor {
    return [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
}

+ (UIColor *)buttonColor {
    return [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
}

+ (UIColor *)fieldColor {
    return [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
}

+ (UIColor *)rgbColor102 {
    return [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
}

+ (UIColor *)rgbColor51 {
    return [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
}


//////
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)pixHeight {
    return 1/[UIScreen mainScreen].scale;
}


///////

+ (UIFont *)font12 {
    return [UIFont systemFontOfSize:12];
}

+ (UIFont *)font14 {
    return [UIFont systemFontOfSize:14];
}

+ (UIFont *)font15 {
    return [UIFont systemFontOfSize:15];
}

+ (UIFont *)font16 {
    return [UIFont systemFontOfSize:16];
}


@end
