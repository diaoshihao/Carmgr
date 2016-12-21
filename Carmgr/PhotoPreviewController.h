//
//  PhotoPreviewController.h
//  Carmgr
//
//  Created by admin on 2016/12/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPreviewController : UIViewController

@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, assign) BOOL animated;

@end
