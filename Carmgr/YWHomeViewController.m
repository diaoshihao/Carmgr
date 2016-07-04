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
#import "NavigationAttribute.h"
#import "HomeView.h"

@interface YWHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HomeView *home;

@property (nonatomic, strong) NSMutableArray *viewsArr;

@property (nonatomic, strong) NSArray      *imageArr;
@property (nonatomic, strong) NSArray      *titleArr;

@end

@implementation YWHomeViewController

#pragma mark - 懒加载
- (NSMutableArray *)viewsArr {
    if (_viewsArr == nil) {
        [self loadData];
    }
    return _viewsArr;
}

- (void)loadData {
    self.viewsArr = [[NSMutableArray alloc] init];
    [self.viewsArr addObject:[self.home createServiceCollectionView]];
    [self.viewsArr addObject:[self.home createActivetyView]];
    [self.viewsArr addObject:[self.home createSecondView]];
    [self.viewsArr addObject:[self.home createUsedCarCollectionView]];
    [self.viewsArr addObject:[self.home createTableViewAtSuperView:self.view broview:nil]];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self homeViewAttribute];
    
//    [self getData];
    
    [self createTableView];
        
}

//数据请求
- (void)getData {
    [YWPublic afPOST:kSERVICES parameters:@"username=diaoshihao&version=1.0" success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark 数据
- (void)homeViewAttribute {
    self.home = [[HomeView alloc] init];
    self.home.VC = self;
    self.home.imageArr = @[@"圆角矩形1",@"圆角矩形2",@"圆角矩形3",@"圆角矩形4",@"圆角矩形5",@"圆角矩形6",@"圆角矩形7",@"圆角矩形1",@"圆角矩形2",@"圆角矩形3"];
    self.home.titleArr = @[@"车险",@"上牌",@"车检",@"维修",@"驾考",@"保养",@"车贷",@"租车",@"二手",@"分类"];
    self.home.usedCarImageArr = @[@"圆角矩形1",@"圆角矩形2",@"圆角矩形3",@"圆角矩形4",@"圆角矩形5",@"圆角矩形6",@"圆角矩形7"];
    
    self.home.actImageDict = @{@"leftImage":@"u10",@"topImage":@"u10",@"bottomImage":@"u10"};
    self.home.secondImageDict = @{@"left1Image":@"u10",@"left2Image":@"u10",@"left3Image":@"u10",@"right1Image":@"u10",@"right2Image":@"u10",@"right3Image":@"u10"};
    
    self.home.hotImageArr = @[@"圆角矩形1",@"圆角矩形2",@"圆角矩形3",@"圆角矩形4",@"圆角矩形5"];
    
}

#pragma mark - tableView
- (void)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.allowsSelection = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.tableHeaderView = [self.home createCycleScrollView:@[@"u10",@"u10"]];
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewsArr.count;
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
        return 0;
    } else {
        return 2.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell addSubview:self.viewsArr[indexPath.section]];
    
    return cell;
}

//及时更改城市名
- (void)viewWillAppear:(BOOL)animated {
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    UIButton *cityButton = [self.navigationItem.leftBarButtonItem.customView.subviews firstObject];
    [cityButton setTitle:city forState:UIControlStateNormal];
}

- (void)hideSearchBar:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
