//
//  CycleScrollView.h
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageTap)(NSUInteger index);

@interface CycleScrollView : UIScrollView

@property (nonatomic, strong) NSArray <NSString *>*images;

@property (nonatomic, assign) BOOL autoScroll;

@property (nonatomic, copy) ImageTap imageTap;

- (void)imageViewDidTap:(ImageTap)imageTap;

@end
