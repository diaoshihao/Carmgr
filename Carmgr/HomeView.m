//
//  HomeView.m
//  Carmgr
//
//  Created by admin on 16/6/30.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HomeView.h"
#import <Masonry.h>
#import "YWPublic.h"
#import "ServiceCollectionCell.h"
#import "DevelopViewController.h"
#import "ServiceCollection.h"
#import "UsedCarCollectionCell.h"
#import "HotTableViewCell.h"

@interface HomeView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, assign) CGFloat width;

@end

@implementation HomeView
{
    UICollectionView *usedCarCollectionView;
    UICollectionView *serviceCollectionView;
}

- (CGFloat)width {
    if (_width == 0) {
        self.width = [UIScreen mainScreen].bounds.size.width;
    }
    return _width;
}

- (UIButton *)createButton:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 轮播图
- (SDCycleScrollView *)createCycleScrollView:(NSArray *)imageNameGroup {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width / 2.5;
        
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, height) delegate:nil placeholderImage:[UIImage imageNamed:@"u10"]];
    cycleScrollView.imageURLStringsGroup = imageNameGroup;
    cycleScrollView.autoScrollTimeInterval = 3.5;
    return cycleScrollView;
    
}

#pragma mark - 活动
- (UIView *)createActivetyView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/3)];
    
    UIButton *leftBtn = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.actImageDict[@"leftImage"]];
    [backView addSubview:leftBtn];
    UIButton *topBtn = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.actImageDict[@"topImage"]];
    [backView addSubview:topBtn];
    UIButton *bottomBtn = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.actImageDict[@"bottomImage"]];
    [backView addSubview:bottomBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.width/2-1);
    }];
    
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(leftBtn.mas_width);
        make.height.mas_equalTo(backView.frame.size.height/2-1);
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(topBtn);
    }];
    
    return backView;
}

#pragma mark - 优惠
- (UIView *)createSecondView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/2)];
    
    //leftBtn
    UIButton *left1 = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.secondImageDict[@"left1Image"]];
    [backView addSubview:left1];
    UIButton *left2 = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.secondImageDict[@"left2Image"]];
    [backView addSubview:left2];
    UIButton *left3 = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.secondImageDict[@"left3Image"]];
    [backView addSubview:left3];
    
    //rightBtn
    UIButton *right1 = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.secondImageDict[@"right1Image"]];
    [backView addSubview:right1];
    UIButton *right2 = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.secondImageDict[@"right2Image"]];
    [backView addSubview:right2];
    UIButton *right3 = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:self.secondImageDict[@"right3Image"]];
    [backView addSubview:right3];
    
    CGFloat height = (backView.frame.size.height-4)/3;
    //left
    [left1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    [left2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(left1.mas_bottom).with.offset(2);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    [left3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    
    //right
    [right1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    [right2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(right1.mas_bottom).with.offset(2);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    [right3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    
    return backView;
}

#pragma mark - 业务板块
- (UIView *)createServiceCollectionView {
    CGFloat width = (self.width - 30*4 - 20*2) / 5;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 2 * width + 100)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.itemSize = CGSizeMake(width, width+20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    serviceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    serviceCollectionView.backgroundColor = [UIColor whiteColor];
    
    serviceCollectionView.delegate = self;
    serviceCollectionView.dataSource = self;
    
    [serviceCollectionView registerClass:[ServiceCollectionCell class] forCellWithReuseIdentifier:[ServiceCollectionCell getCellID]];
    [backView addSubview:serviceCollectionView];
    
    [serviceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).with.offset(0);
        make.left.mas_equalTo(backView.mas_left).with.offset(0);
        make.right.mas_equalTo(backView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).with.offset(0);
    }];
    
    return backView;
}

#pragma mark 二手车推荐
- (UIView *)createUsedCarCollectionView {
    CGFloat width = self.width / 4;
    CGFloat height = width * 3 / 4;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height + 60)];
    
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    myLayout.sectionInset = UIEdgeInsetsMake(5, 15, 20, 10);
    myLayout.itemSize = CGSizeMake(width, height);
    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    usedCarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:myLayout];
    usedCarCollectionView.backgroundColor = [UIColor whiteColor];
    
    usedCarCollectionView.delegate = self;
    usedCarCollectionView.dataSource = self;
    
    [usedCarCollectionView registerClass:[UsedCarCollectionCell class] forCellWithReuseIdentifier:[UsedCarCollectionCell getReuseID]];
    [backView addSubview:usedCarCollectionView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
    [backView addSubview:headView];
    [self createHeadViewWithTitle:@"热门二手车" superView:headView];
    
    [usedCarCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).with.offset(30);
        make.left.mas_equalTo(backView.mas_left).with.offset(0);
        make.right.mas_equalTo(backView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).with.offset(0);
    }];
    
    return backView;
}

- (UIView *)createTableViewAtSuperView:(UIView *)superView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.hotImageArr.count * 44 + 30)];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
    [backView addSubview:headView];
    [self createHeadViewWithTitle:@"热门推荐" superView:headView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [backView addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[HotTableViewCell class] forCellReuseIdentifier:[HotTableViewCell getReuseID]];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(backView).with.offset(0);
        make.right.mas_equalTo(backView).with.offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).with.offset(0);
    }];
    return backView;
}

//小标题
- (void)createHeadViewWithTitle:(NSString *)title superView:(UIView *)superView {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:15];
    [superView addSubview:label];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [superView addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"前进1"];
    [superView addSubview:imageView];

    CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(labelSize);
        make.centerY.mas_equalTo(superView);
    }];
    
    CGSize buttonSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(buttonSize.height-5, buttonSize.height-5));
        make.centerY.mas_equalTo(superView);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_left).with.offset(-3);
        make.size.mas_equalTo(buttonSize);
        make.centerY.mas_equalTo(superView);
    }];
    
}

#pragma mark - CollectionView delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == usedCarCollectionView) {
        return 15;
    } else {
        return 30; //固定间距30
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == usedCarCollectionView) {
        return self.usedCarImageArr.count;
    } else {
        return self.imageArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == usedCarCollectionView) {
        UsedCarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UsedCarCollectionCell getReuseID] forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:self.usedCarImageArr[indexPath.item]];
        return cell;
    } else {
        ServiceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ServiceCollectionCell getCellID] forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.item]];
        cell.titleLabel.text = self.titleArr[indexPath.item];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DevelopViewController *developVC = [[DevelopViewController alloc] init];
    [self.VC presentViewController:developVC animated:YES completion:nil];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotImageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HotTableViewCell getReuseID]];
    cell.hotImageView.image = [UIImage imageNamed:self.hotImageArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DevelopViewController *developVC = [[DevelopViewController alloc] init];
    [self.VC presentViewController:developVC animated:YES completion:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
