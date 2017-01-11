//
//  ScrollPagingView.h
//  Carmgr
//
//  Created by admin on 2017/1/3.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollPagingView : UIScrollView

@property (nonatomic, assign) CGFloat itemSpace;

@property (nonatomic, strong) NSArray *viewObjs;

//自定义分页宽度初始化方法
- (instancetype)initWithItemSpace:(CGFloat)itemSpace viewObjs:(NSArray *)viewObjs;

@end
