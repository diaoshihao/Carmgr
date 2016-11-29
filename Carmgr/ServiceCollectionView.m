//
//  ServiceCollectionView.m
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceCollectionView.h"
#import "ServiceCollectionCell.h"
#import "HomeModel.h"
#import <Masonry.h>

@interface ServiceCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ServiceCollectionView
{
    UICollectionView *_serviceCollectionView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createServiceCollectionView];
    }
    return self;
}

- (void)reloadData {
    [_serviceCollectionView reloadData];
}

- (void)createServiceCollectionView {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 27.5*4 - 20*2) / 5;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.itemSize = CGSizeMake(width, width+20);
    
    _serviceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _serviceCollectionView.backgroundColor = [UIColor whiteColor];
    _serviceCollectionView.scrollEnabled = NO;
    
    _serviceCollectionView.delegate = self;
    _serviceCollectionView.dataSource = self;
    
    [_serviceCollectionView registerClass:[ServiceCollectionCell class] forCellWithReuseIdentifier:[ServiceCollectionCell getCellID]];
    [self addSubview:_serviceCollectionView];
    
    [_serviceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - CollectionView delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20; //固定间距30
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 27.5; //固定间距30
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ServiceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ServiceCollectionCell getCellID] forIndexPath:indexPath];
    
    ServiceModel *model = self.dataArr[indexPath.item];
    //异步加载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = nil;
        NSError *error;
        NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon_path] options:NSDataReadingMappedIfSafe error:&error];
        image = [UIImage imageWithData:responseData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    });
    cell.titleLabel.text = model.service_name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ServiceModel *model = self.dataArr[indexPath.item];
    self.didSelectItem(model);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
