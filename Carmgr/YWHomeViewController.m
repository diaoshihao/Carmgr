//
//  YWHomeViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWHomeViewController.h"
#import "HomeView.h"
#import "YWLoginViewController.h"
#import "ServiceViewController.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "HomeDataLoader.h"
#import "HomeModel.h"

#import "CycleScrollView.h"
#import "PromotionView.h"
#import "ServiceCollectionView.h"
#import "SecondHandCollectionView.h"

@interface YWHomeViewController () <HomeDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) HomeDataLoader *dataLoader;

@property (nonatomic, strong) CycleScrollView *cycleScrollView;
@property (nonatomic, strong) ServiceCollectionView *serviceCollection;
@property (nonatomic, strong) PromotionView *promotionView;
@property (nonatomic, strong) DiscountView *discountView;
@property (nonatomic, strong) SecondHandCollectionView *secondHandCollection;

@end

@implementation YWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;

    //实例化加载数据类
    self.dataLoader = [[HomeDataLoader alloc] init];
    self.dataLoader.dataSource = self;
    
    [self showPage];
    
    //添加下拉刷新控件
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //加载数据
        [self.dataLoader loadData];
    }];
    [self refresh];
}

- (void)showPage {
    [self initContentView];
    [self addViewToContentView];
}

//实现父类的方法
- (void)refresh {
    [self.scrollView.mj_header beginRefreshing];
}

#pragma mark homeDataSource
- (void)requestAllDone {
    [self.scrollView.mj_header endRefreshing];
}

- (void)loadSuccess {
    
}

- (void)loadFailed {
    
}

- (void)loadConfig_key:(Config_Key)config_key data:(NSArray *)data {
    [self loadImageWithKey:config_key data:data];
}

- (void)loadServices:(NSArray *)services {
    NSMutableArray *servicesArr = [NSMutableArray new];
    for (NSDictionary *dict in services) {
        ServiceModel *model = [[ServiceModel alloc] initWithDict:dict];
        [servicesArr addObject:model];
    }
    self.serviceCollection.dataArr = servicesArr;
    [self.serviceCollection reloadData];
}

- (void)loadSecondHand:(NSArray *)secondHand {
    NSMutableArray *secondHandArr = [NSMutableArray new];
    for (NSDictionary *dict in secondHand) {
        UsedCarModel *model = [[UsedCarModel alloc] initWithDict:dict];
        [secondHandArr addObject:model];
    }
    self.secondHandCollection.dataArr = secondHandArr;
    [self.secondHandCollection reloadData];
}

//loadImageByKey
- (void)loadImageWithKey:(Config_Key)config_key data:(NSArray *)data {
    NSMutableArray *images = [NSMutableArray new];
    for (NSDictionary *dict in data) {
        HomeModel *homeModel = [HomeModel modelWithDict:dict];
        [images addObject:homeModel.config_value];
    }
    if (config_key == Config_ZY0001) {
        self.cycleScrollView.images = images;
    } else if (config_key == Config_ZY0002) {
        [self.promotionView setImageFor:PositionLeft imageUrl:images.firstObject];
    } else if (config_key == Config_ZY0003) {
        [self.promotionView setImageFor:PositionRightTop imageUrl:images.firstObject];
    } else if (config_key == Config_ZY0004) {
        [self.promotionView setImageFor:PositionRightBottom imageUrl:images.firstObject];
    }else if (config_key == Config_ZY0005) {
        [self.discountView setDiscountImages:images];
    } else {
        
    }
}

- (void)pushToServicePage:(ServiceModel *)model {
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    serviceVC.service_filter = model.service_name;
    [self.navigationController pushViewController:serviceVC animated:YES];
}

- (void)cycleImageDidTap {
    
}

- (void)promotionButtonDidTap:(ButtonPosition)position {
    
}

- (void)discountButtonDidTap:(ButtonPosition)position {
    
}

#pragma mark -
- (void)initContentView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [DefineValue separaColor];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo([DefineValue screenWidth]);
    }];
}

- (void)addViewToContentView {
    __weak typeof(self) weakSelf = self;
    
    self.cycleScrollView = [[CycleScrollView alloc] init];
    [self.cycleScrollView imageViewDidTap:^(NSUInteger index) {
        [weakSelf cycleImageDidTap];
    }];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 300 / 720);
    }];
    
    CGFloat itemWidth = ([DefineValue screenWidth] - 27.5 * 4 - 20 * 2) / 5;
    self.serviceCollection = [[ServiceCollectionView alloc] init];
    self.serviceCollection.didSelectItem = ^(ServiceModel *model) {
        [weakSelf pushToServicePage:model];
    };
    [self.contentView addSubview:self.serviceCollection];
    [self.serviceCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(2 * itemWidth + 100);
    }];
    
    CGFloat promotionHeight = [DefineValue screenWidth] / 2 * 26 / 36;
    self.promotionView = [[PromotionView alloc] init];
    self.promotionView.click = ^(ButtonPosition position) {
        [weakSelf promotionButtonDidTap:position];
    };
    [self.contentView addSubview:self.promotionView];
    [self.promotionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.serviceCollection.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(promotionHeight);
    }];
    
    CGFloat discountHeight = 3 * [DefineValue screenWidth] / 2 * 13 / 36;
    self.discountView = [[DiscountView alloc] init];
    self.discountView.click = ^(ButtonPosition position) {
        [weakSelf discountButtonDidTap:position];
    };
    [self.contentView addSubview:self.discountView];
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.promotionView.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(discountHeight);
    }];
    
    CGFloat secondwidth = [DefineValue screenWidth] / 4;
    CGFloat height = secondwidth * 124 / 170 + 30;

    self.secondHandCollection = [[SecondHandCollectionView alloc] init];
    [self.contentView addSubview:self.secondHandCollection];
    [self.secondHandCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discountView.mas_bottom).offset(8);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
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
