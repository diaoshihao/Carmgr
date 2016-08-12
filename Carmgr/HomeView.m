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

#import "DevelopViewController.h"
#import "ServiceViewController.h"

#import "ServiceCollectionCell.h"
#import "UsedCarCollectionCell.h"
#import "HotTableViewCell.h"

#import "ServiceModel.h"
#import "UsedCarModel.h"

@interface HomeView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) NSArray *service_filters;

@end

@implementation HomeView
{
    UICollectionView *usedCarCollectionView;
    UICollectionView *serviceCollectionView;
}

- (NSArray *)service_filters {
    if (_service_filters == nil) {
        _service_filters = @[@"保养",@"维修",@"加油",@"二手",@"代驾",@"保养",@"车险",@"保养",@"保养"];
    }
    return _service_filters;
}

- (NSMutableArray *)serviceDataArr {
    if (_serviceDataArr == nil) {
        _serviceDataArr = [[NSMutableArray alloc] init];
    }
    return _serviceDataArr;
}

- (NSMutableArray *)usedCarDataArr {
    if (_usedCarDataArr == nil) {
        _usedCarDataArr = [[NSMutableArray alloc] init];
    }
    return _usedCarDataArr;
}

- (NSMutableArray *)discountArr {
    if (_discountArr == nil) {
        _discountArr = [[NSMutableArray alloc] init];
    }
    return _discountArr;
}

- (NSMutableArray *)actLeftArr {
    if (_actLeftArr == nil) {
        _actLeftArr = [[NSMutableArray alloc] init];
    }
    return _actLeftArr;
}

- (NSMutableArray *)actTopArr {
    if (_actTopArr == nil) {
        _actTopArr = [[NSMutableArray alloc] init];
    }
    return _actTopArr;
}

- (NSMutableArray *)actBottomArr {
    if (_actBottomArr == nil) {
        _actBottomArr = [[NSMutableArray alloc] init];
    }
    return _actBottomArr;
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
    CGFloat height = width * 300 / 720;
        
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, height) delegate:self placeholderImage:[UIImage imageNamed:@"u10"]];
    
    cycleScrollView.imageURLStringsGroup = imageNameGroup;
    cycleScrollView.autoScrollTimeInterval = 3.5;
    if (imageNameGroup.count == 1) {
        cycleScrollView.autoScroll = NO;
    } else {
        cycleScrollView.autoScroll = YES;
    }
    
    return cycleScrollView;
    
}

#pragma mark - cycleImageDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [YWPublic userOperationInClickAreaID:@"1000_1" detial:@"轮播图"];
}

//为以下提供创建button方法
- (UIButton *)createActivetyBtn:(NSString *)imageUrl tag:(NSInteger)tag {
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:nil];
    button.tag = tag;
    if (imageUrl != nil) {
        [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]] forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 活动
- (UIView *)createActivetyView {
    
    CGFloat width = self.width/2-1;
    CGFloat height = width*26/36;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (self.actLeftArr.count == 0 || self.actTopArr.count == 0 || self.actBottomArr.count == 0) {
        return backView;
    }
    
    UIButton *leftBtn = [self createActivetyBtn:self.actLeftArr[0] tag:100];
    [backView addSubview:leftBtn];
    
    UIButton *topBtn = [self createActivetyBtn:self.actTopArr[0] tag:200];
    [backView addSubview:topBtn];
    
    UIButton *bottomBtn = [self createActivetyBtn:self.actBottomArr[0] tag:300];
    [backView addSubview:bottomBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.width/2);
    }];
    
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height/2-1);
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height/2);
    }];
    
    return backView;
}

//为以下提供创建button方法
- (UIButton *)createBtn:(NSString *)imageUrl tag:(NSInteger)tag {
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:nil];
    button.tag = tag;
    if (imageUrl == nil) {
        [button setImage:[UIImage imageNamed:@"u10"] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]] forState:UIControlStateNormal];
    }
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 优惠
- (UIView *)createSecondView {
    
    CGFloat bvHeight = ((self.width/2-1)*26/36-2)/2;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 3*bvHeight+4)];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (self.discountArr.count == 0) {
        return backView;
    }
    
    //leftBtn
    UIButton *left1 = [self createBtn:self.discountArr[0] tag:400];
    [backView addSubview:left1];
    
    UIButton *left2 = [self createBtn:self.discountArr[1] tag:500];
    [backView addSubview:left2];
    
    UIButton *left3 = [self createBtn:self.discountArr[2] tag:600];
    [backView addSubview:left3];
    
    
    //rightBtn
    UIButton *right1 = [self createBtn:self.discountArr[3] tag:700];
    [backView addSubview:right1];
    
    UIButton *right2 = [self createBtn:self.discountArr[4] tag:800];
    [backView addSubview:right2];
    
    UIButton *right3 = [self createBtn:self.discountArr[5] tag:900];
    [backView addSubview:right3];
    
    
    CGFloat height = (backView.frame.size.height-2)/3;
    //left
    [left1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2, height));
    }];
    [left2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(left1.mas_bottom).with.offset(1);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2, height));
    }];
    [left3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2, height));
    }];
    
    //right
    [right1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.width/2-1, height));
    }];
    [right2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(right1.mas_bottom).with.offset(1);
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

//活动优惠按钮点击跳转到相应界面
- (void)buttonClick:(UIButton *)sender {
//    DevelopViewController *developVC = [[DevelopViewController alloc] init];
//    [self.VC presentViewController:developVC animated:YES completion:nil];
    
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    serviceVC.service_filter = self.service_filters[sender.tag/100-1];
    [self.VC.navigationController pushViewController:serviceVC animated:YES];
    
}

#pragma mark - 业务板块
- (UIView *)createServiceCollectionView {
    CGFloat width = (self.width - 27.5*4 - 20*2) / 5;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 2 * width + 100)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.itemSize = CGSizeMake(width, width+20);
    
    serviceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    serviceCollectionView.backgroundColor = [UIColor whiteColor];
    serviceCollectionView.scrollEnabled = NO;
    
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
    CGFloat height = width * 124 / 170;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height+51)];
    
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    myLayout.sectionInset = UIEdgeInsetsMake(0, 20, 10, 20);
    myLayout.itemSize = CGSizeMake(width, height);
    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    usedCarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:myLayout];
    usedCarCollectionView.backgroundColor = [UIColor whiteColor];
    usedCarCollectionView.showsHorizontalScrollIndicator = NO;
    
    usedCarCollectionView.delegate = self;
    usedCarCollectionView.dataSource = self;
    
    [usedCarCollectionView registerClass:[UsedCarCollectionCell class] forCellWithReuseIdentifier:[UsedCarCollectionCell getReuseID]];
    [backView addSubview:usedCarCollectionView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
    [backView addSubview:headView];
    [self createHeadViewWithTitle:@"热门二手车" superView:headView];
    
    [usedCarCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).with.offset(0);
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
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [superView addSubview:label];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [superView addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"前进黑"];
    imageView.contentMode = UIViewContentModeCenter;
    [superView addSubview:imageView];

    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(superView);
    }];
    
    CGSize buttonSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).with.offset(-20);
        make.centerY.mas_equalTo(superView);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageView.mas_left).with.offset(-5);
        make.size.mas_equalTo(buttonSize);
        make.centerY.mas_equalTo(superView);
    }];
    
}

#pragma mark - CollectionView delegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == usedCarCollectionView) {
        return 10;
    }
    return 20; //固定间距30
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == usedCarCollectionView) {
        return 20;
    }
    return 27.5; //固定间距30
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == usedCarCollectionView) {
        return self.usedCarDataArr.count;
    } else {
        return self.serviceDataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == usedCarCollectionView) {
        UsedCarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UsedCarCollectionCell getReuseID] forIndexPath:indexPath];
        UsedCarModel *model = self.usedCarDataArr[indexPath.item];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.img_path]]];
        return cell;
    } else {
        ServiceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ServiceCollectionCell getCellID] forIndexPath:indexPath];
        
        ServiceModel *model = self.serviceDataArr[indexPath.item];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon_path]]];
        cell.titleLabel.text = model.service_name;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == serviceCollectionView) {
        ServiceModel *model = self.serviceDataArr[indexPath.item];
        NSString *click_area_id = [NSString stringWithFormat:@"1000_%ld",indexPath.item+10];
        [YWPublic userOperationInClickAreaID:click_area_id detial:model.service_name];
        ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
        serviceVC.service_filter = model.service_name;
        [self.VC.navigationController pushViewController:serviceVC animated:YES];
    } else {
        [YWPublic userOperationInClickAreaID:@"1000_40" detial:@"二手车"];
        DevelopViewController *developVC = [[DevelopViewController alloc] init];
        [self.VC presentViewController:developVC animated:YES completion:nil];
    }
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
