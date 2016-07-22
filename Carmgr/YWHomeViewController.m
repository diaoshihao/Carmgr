//
//  YWHomeViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWHomeViewController.h"
#import "YWUserViewController.h"
#import "YWPublic.h"
#import "HomeView.h"
#import "YWLoginViewController.h"
#import "NetworkingForData.h"

@interface YWHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HomeView          *home;
@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) NSMutableArray    *viewsArr;

@property (nonatomic, strong) NSMutableArray    *cycleImageArr;//轮播图组

@end

@implementation YWHomeViewController

#pragma mark - 懒加载
- (NSMutableArray *)viewsArr {
    if (_viewsArr == nil) {
        _viewsArr = [[NSMutableArray alloc] init];
    }
    return _viewsArr;
}

- (NSMutableArray *)cycleImageArr {
    if (_cycleImageArr == nil) {
        _cycleImageArr = [[NSMutableArray alloc] init];
    }
    return _cycleImageArr;
}

- (void)loadCellViews {
    
    [self.viewsArr addObject:[self.home createServiceCollectionView]];
    [self.viewsArr addObject:[self.home createActivetyView]];
    [self.viewsArr addObject:[self.home createSecondView]];
    [self.viewsArr addObject:[self.home createUsedCarCollectionView]];
//    [self.viewsArr addObject:[self.home createTableViewAtSuperView:self.view]];
}

#pragma mark 跳转到个人中心
- (void)pushToUser:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[YWUserViewController alloc] init] animated:YES];
}

#pragma mark 选择城市
- (void)chooseCityAction:(UIButton *)sender {
    CityChooseViewController *cityChooseVC = [[CityChooseViewController alloc] init];
    [cityChooseVC returnCityInfo:^(NSString *province, NSString *area) {
        
        [[NSUserDefaults standardUserDefaults] setObject:area forKey:@"city"];
    }];
    [self.navigationController pushViewController:cityChooseVC animated:YES];
}

#pragma mark 获取图片
- (void)loadImage {
    NetworkingForData *network = [[NetworkingForData alloc] init];
    
    //数据源
    network.propertys = @[self.cycleImageArr,self.home.actLeftArr,self.home.actTopArr,self.home.actBottomArr,self.home.discountArr];
    network.serviceDataArr = self.home.serviceDataArr;
    network.usedCarDataArr = self.home.usedCarDataArr;
    
    network.outDate = NO;
    network.outLine = NO;
    
    dispatch_group_t group = dispatch_group_create();
    
    [network getSource:group];//资源
    [network getService:group];//服务
    [network getUsedCar:group];//二手车
//    [network getHotSource:group];//热门推荐
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (network.outDate) {                  //token过期
            [self.tableView.mj_header endRefreshing];
            UIAlertController *alertVC = [YWPublic showReLoginAlertViewAt:self];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else if (network.outLine) {           //网络错误
            [self.tableView.mj_header endRefreshing];
            UIAlertController *alertVC = [YWPublic showFaileAlertViewAt:self];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else {
            [self.tableView.mj_header endRefreshing];
            [self.viewsArr removeAllObjects];
            [self loadCellViews];
            [self.tableView reloadData];
        }
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.home = [[HomeView alloc] init];
    self.home.VC = self;
    
    [self createTableView];
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadImage];
    }];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - tableView
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [self.view addGestureRecognizer:tap];
    
}
- (void)hideSearchBar:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewsArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [self.home createCycleScrollView:self.cycleImageArr];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = self.viewsArr[indexPath.section];
    return view.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIScreen mainScreen].bounds.size.width/2.5;
    } else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 9.9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell addSubview:self.viewsArr[indexPath.section]];
    
    return cell;
}

//及时更改城市名
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;//    Bar的模糊效果，默认为YES
    
    //获取并设置当前城市名
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    UIButton *cityButton = [self.navigationItem.leftBarButtonItem.customView.subviews firstObject];
    [cityButton setTitle:city forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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
