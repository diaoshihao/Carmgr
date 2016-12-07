//
//  SecondHandCollectionView.m
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "SecondHandCollectionView.h"
#import "UsedCarCollectionCell.h"
#import "HomeModel.h"
#import <Masonry.h>
#import "CustomButton.h"

@interface SecondHandCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SecondHandCollectionView

{
    UILabel *_titleLabel;
    UICollectionView *_secondHandCollectionView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self titleView];
        [self createServiceCollectionView];
    }
    return self;
}

- (void)reloadData {
    [_secondHandCollectionView reloadData];
}

- (void)titleView {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"热门二手车";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
    
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom imagePosition:ImagePositionRight];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setImage:[UIImage imageNamed:@"前进黑"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lookMoreSecondHand:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(_titleLabel.mas_height);
    }];
}

- (void)lookMoreSecondHand:(CustomButton *)sender {
    self.lookMore();
}

- (void)createServiceCollectionView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4;
    CGFloat height = width * 124 / 170;
    
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    myLayout.sectionInset = UIEdgeInsetsMake(0, 20, 10, 20);
    myLayout.itemSize = CGSizeMake(width, height);
    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _secondHandCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:myLayout];
    _secondHandCollectionView.backgroundColor = [UIColor whiteColor];
    _secondHandCollectionView.showsHorizontalScrollIndicator = NO;
    
    _secondHandCollectionView.delegate = self;
    _secondHandCollectionView.dataSource = self;
    
    [_secondHandCollectionView registerClass:[UsedCarCollectionCell class] forCellWithReuseIdentifier:[UsedCarCollectionCell getReuseID]];
    [self addSubview:_secondHandCollectionView];
    
    [_secondHandCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.left.and.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - CollectionView delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10; //固定间距30
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20; //固定间距30
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UsedCarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UsedCarCollectionCell getReuseID] forIndexPath:indexPath];
    UsedCarModel *model = self.dataArr[indexPath.item];
    //异步加载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = nil;
        NSError *error;
        NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img_path] options:NSDataReadingMappedIfSafe error:&error];
        image = [UIImage imageWithData:responseData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    });
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
