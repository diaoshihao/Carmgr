//
//  SecondHandCollectionView.h
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LookMore)(void);

@interface SecondHandCollectionView : UIView

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, copy) LookMore lookMore;

- (void)reloadData;

@end
