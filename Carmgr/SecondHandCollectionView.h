//
//  SecondHandCollectionView.h
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondHandCollectionView : UIView

@property (nonatomic, strong) NSArray *dataArr;

- (void)reloadData;

@end
