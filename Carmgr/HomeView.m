//
//  HomeView.m
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HomeView.h"
#import "CollectionCell.h"
#import "ServiceCollectionCell.h"
#import <Masonry.h>

@interface HomeView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign) CGFloat width;

@end

@implementation HomeView

#pragma mark 轮播图
- (SDCycleScrollView *)createCycleScrollView:(NSArray *)imageNameGroup {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width / 2.5;
        
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, height) delegate:nil placeholderImage:[UIImage imageNamed:@"u10"]];
    cycleScrollView.imageURLStringsGroup = imageNameGroup;
    cycleScrollView.autoScrollTimeInterval = 3.5;
    return cycleScrollView;
    
}

#pragma mark 业务板块
- (UICollectionView *)createCollectionViewAtSuperView:(UIView *)superView {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(15, 20, 15, 20);
    self.width = ([UIScreen mainScreen].bounds.size.width - 150) / 5;
    layout.itemSize = CGSizeMake(self.width, self.width+20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[ServiceCollectionCell class] forCellWithReuseIdentifier:[ServiceCollectionCell getCellID]];
    [superView addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(superView);
    }];
    
    return collectionView;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ServiceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ServiceCollectionCell getCellID] forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.item]];
    cell.titleLabel.text = self.titleArr[indexPath.item];
    
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
