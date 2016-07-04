//
//  ServiceCollection.m
//  Carmgr
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceCollection.h"
#import <Masonry.h>
#import "YWPublic.h"
#import "ServiceCollectionCell.h"
#import "DevelopViewController.h"

@interface ServiceCollection() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign) CGFloat width;

@end

@implementation ServiceCollection
- (CGFloat)width {
    if (_width == 0.0) {
        self.width = [UIScreen mainScreen].bounds.size.width;
    }
    return _width;
}

- (void)createServiceCollectionViewAtSuperView:(UIView *)superView {
    CGFloat width = (self.width - 30*4 - 20*2) / 5;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.itemSize = CGSizeMake(width, width+20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[ServiceCollectionCell class] forCellWithReuseIdentifier:[ServiceCollectionCell getCellID]];
    [superView addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top).with.offset(0);
        make.left.mas_equalTo(superView.mas_left).with.offset(0);
        make.right.mas_equalTo(superView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(superView.mas_bottom).with.offset(0);
    }];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30; //固定间距30
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DevelopViewController *developVC = [[DevelopViewController alloc] init];
    [self.VC presentViewController:developVC animated:YES completion:nil];
}

@end
