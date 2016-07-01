//
//  HomeView.h
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface HomeView : UIView

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;

- (SDCycleScrollView *)createCycleScrollView:(NSArray *)imageNameGroup;

- (UICollectionView *)createCollectionViewAtSuperView:(UIView *)superView;

@end
