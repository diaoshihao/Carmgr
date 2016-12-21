//
//  PhotoPreviewController.m
//  Carmgr
//
//  Created by admin on 2016/12/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "PhotoPreviewController.h"
#import "PreviewCollectionViewCell.h"

@interface PhotoPreviewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation PhotoPreviewController
{
    CGFloat _width;
    CGFloat _height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configCollectionView];
    [self configPageControl];
}

- (void)configCollectionView {
    _width = [DefineValue screenWidth];
    _height = [DefineValue screenHeight];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(_width + 20, _height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, _width + 20, _height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 0);
    _collectionView.contentSize = CGSizeMake(self.photos.count * (_width + 20), 0);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[PreviewCollectionViewCell class] forCellWithReuseIdentifier:@"PreviewCollectionViewCell"];
}

- (void)configPageControl {
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = self.photos.count;
    [self.view addSubview:_pageControl];
    [self.view bringSubviewToFront:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-0.2 * _height);
    }];
}

- (void)viewDidLayoutSubviews {
    NSIndexPath *collectionIndexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
    [_collectionView scrollToItemAtIndexPath:collectionIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _pageControl.currentPage = _currentIndex;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSUInteger currentIndex = _collectionView.contentOffset.x / (_width + 20);
    _pageControl.currentPage = currentIndex;
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PreviewCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = _photos[indexPath.row];
    
    if (!cell.singleTapGestureBlock) {
        __weak typeof(self) weakSelf = self;
        cell.singleTapGestureBlock = ^(){
            if (weakSelf.presentingViewController) {
                [weakSelf dismissViewControllerAnimated:_animated completion:nil];
            } else {
                [weakSelf.navigationController popViewControllerAnimated:_animated];
            }
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[PreviewCollectionViewCell class]]) {
        [(PreviewCollectionViewCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[PreviewCollectionViewCell class]]) {
        [(PreviewCollectionViewCell *)cell recoverSubviews];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
