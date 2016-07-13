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
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *viewsArr;
@property (nonatomic, strong) NSMutableArray *cycleImageArr;//轮播图组

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

- (NSMutableArray *)cycleImageArr {
    if (_cycleImageArr == nil) {
        _cycleImageArr = [[NSMutableArray alloc] init];
    }
    return _cycleImageArr;
}

- (void)loadData {
    self.viewsArr = [[NSMutableArray alloc] init];
    [self.viewsArr addObject:[self.home createServiceCollectionView]];
    [self.viewsArr addObject:[self.home createActivetyView]];
    [self.viewsArr addObject:[self.home createSecondView]];
    [self.viewsArr addObject:[self.home createUsedCarCollectionView]];
    [self.viewsArr addObject:[self.home createTableViewAtSuperView:self.view]];
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

//按钮点击跳转到相应界面
- (void)buttonClick:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [self homeViewAttribute];
    [self createTableView];
    
//    [self getImageFromNet:@"15014150833" imageName:@"ZY_0001" token:token];
//    [self getImageFromNet:@"15014150833" imageName:@"ZY_0002" token:token];
//    [self getImageFromNet:@"15014150833" imageName:@"ZY_0003" token:token];
//    [self getImageFromNet:@"15014150833" imageName:@"ZY_0004" token:token];
//    [self getImageFromNet:@"15014150833" imageName:@"ZY_0005" token:token];
//    
//    [self getDataFromNet:@"15014150833" token:token];
    
}

#pragma mark 数据
- (void)homeViewAttribute {
    self.home = [[HomeView alloc] init];
    self.home.VC = self;
    self.home.imageArr = @[@"车险",@"上牌",@"车检",@"维修",@"驾考",@"保养",@"车贷",@"租车",@"二手",@"分类"];
    self.home.titleArr = @[@"车险",@"上牌",@"车检",@"维修",@"驾考",@"保养",@"车贷",@"租车",@"二手",@"分类"];
    self.home.usedCarImageArr = @[@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色"];
    
    self.home.actImageDict = @{@"leftImage":@"u10",@"topImage":@"u10",@"bottomImage":@"u10"};
    self.home.secondImageDict = @{@"left1Image":@"u10",@"left2Image":@"u10",@"left3Image":@"u10",@"right1Image":@"u10",@"right2Image":@"u10",@"right3Image":@"u10"};
    
    self.home.hotImageArr = @[@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色"];
    
}

//数据请求
- (void)getDataFromNet:(NSString *)username token:(NSString *)token {
    [YWPublic afPOST:[NSString stringWithFormat:kSERVICES,username,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dataDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//从网络获取图片数据
- (NSArray *)getImageFromNet:(NSString *)username imageName:(NSString *)imageName token:(NSString *)token {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSString *screen_size = [NSString stringWithFormat:@"%lfx%lf",width,height];
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    __block NSMutableArray *dataArr = data;
    
    //请求资源
    [YWPublic afPOST:[NSString stringWithFormat:kCONFIG,username,imageName,screen_size,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        [data addObject:dataDict[@"config_value_list"]];
        
        NSString *imageUrl = dataDict[@"config_value_list"][0][@"config_value"];
        NSLog(@"dict:%@",imageUrl);
        
//        NSURL *url = [NSURL URLWithString:imageUrl];
        
//        [self.cycleImageArr addObject:url];
//        [self.tableView reloadData];
//        [self createTableView]; //获取轮播图后再创建视图
//        NSLog(@"%ld",self.cycleImageArr.count);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"资源请求失败%@",error);
    }];
    NSLog(@"%@,%@",dataArr,data);
    return dataArr;
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
    
    [cell addSubview:self.viewsArr[indexPath.section]];
    
    return cell;
}

//及时更改城市名
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    
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
