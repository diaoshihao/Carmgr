//
//  CurrentServiceScrollView.h
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

//====================当前分类下附近的商家信息========================

#import <UIKit/UIKit.h>

typedef void(^CurrentPageBlock)(NSInteger index);

@interface CurrentServiceScrollView : UIScrollView

@property (nonatomic, strong) NSArray *nearbyServices;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, copy) CurrentPageBlock currentPageBlock;

- (void)reloadData;

- (void)currentServicePage:(CurrentPageBlock)currentPageBlock;

- (void)scrollToCurrentPage:(NSInteger)index;

@end
