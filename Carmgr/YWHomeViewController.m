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
#import "HomeModel.h"

@interface YWHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HomeView          *home;
@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) NSMutableArray    *viewsArr;
@property (nonatomic, strong) NSMutableArray    *sourceDataArr;//图片资源

@property (nonatomic, strong) NSArray           *imageArr;
@property (nonatomic, strong) NSArray           *titleArr;

@property (nonatomic, strong) NSMutableArray    *cycleImageArr;//轮播图组

@property (nonatomic, strong) NSDictionary      *dataDict;


@end

@implementation YWHomeViewController
{
    NSInteger postCount;//用于判断是否已接收所有资源数据
}

- (NSMutableArray *)sourceDataArr {
    if (_sourceDataArr == nil) {
        _sourceDataArr = [[NSMutableArray alloc] init];
    }
    return _sourceDataArr;
}

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
    postCount = 5;//用于网络请求计数
    
    self.home = [[HomeView alloc] init];
    self.home.VC = self;
    
    [self homeViewAttribute];
    [self createTableView];
    //    [self loadImage];
    
    
}

#pragma mark 获取资源图片
- (void)loadImage {
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSArray *propertys = @[self.cycleImageArr,self.home.actLeftArr,self.home.actTopArr,self.home.actBottomArr,self.home.discountArr];
    
    for (NSInteger i = 0; i < propertys.count; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"ZY_000%ld",(long)i+1];
        [self getImageFromNet:userName imageName:imageName token:token sourceArr:propertys[i]];
    }
    
    [self getDataFromNet:userName token:token];
    //二手车
    //    [self getUsedCarImage:@"15014150833" token:token];
    
}

#pragma mark 数据
- (void)homeViewAttribute {
    
    self.home.imageArr = @[@"车险",@"上牌",@"车检",@"维修",@"驾考",@"保养",@"车贷",@"租车",@"二手",@"分类"];
    self.home.titleArr = @[@"车险",@"上牌",@"车检",@"维修",@"驾考",@"保养",@"车贷",@"租车",@"二手",@"分类"];
    self.home.usedCarImageArr = [NSMutableArray arrayWithArray:@[@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色"]];
    
    self.home.hotImageArr = @[@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色",@"圆角矩形红色"];
    
}

//服务图标数据请求
- (void)getDataFromNet:(NSString *)username token:(NSString *)token {
    [YWPublic afPOST:[NSString stringWithFormat:kSERVICES,username,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dataDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//从网络获取资源图片数据请求
- (void)getImageFromNet:(NSString *)username imageName:(NSString *)imageName token:(NSString *)token sourceArr:(NSMutableArray *)sourceArr {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSString *screen_size = [NSString stringWithFormat:@"%lfx%lf",width,height];
    
    //请求资源
    __block NSMutableArray *arrM = sourceArr;
    [YWPublic afPOST:[NSString stringWithFormat:kCONFIG,username,imageName,screen_size,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        postCount--;//计数-1
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            [arrM removeAllObjects];
            for (NSDictionary *dict in dataDict[@"config_value_list"]) {
                [arrM addObject:dict[@"config_value"]];
            }
        } else {
            if (postCount == 0) {
                [self.tableView.mj_header endRefreshing];
                postCount = 5;//重置计数
                [self showAlertView];
            }
            return ;
        }
        
        if (postCount == 0) {
            [self.tableView.mj_header endRefreshing];
            postCount = 5;//重置计数
            [self.viewsArr removeAllObjects];//重置view个数
            [self loadCellViews];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"图片资源请求失败%@",error);
    }];
}

- (void)showAlertView {
    [self.tableView.mj_header endRefreshing];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户状态已过期，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *login = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:login];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//获取二手车数据
- (void)getUsedCarImage:(NSString *)username token:(NSString *)token {
    
    __block NSMutableArray *arrM = self.home.usedCarImageArr;
    [YWPublic afPOST:[NSString stringWithFormat:kSECONDHAND,username,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dataDict);
        for (NSDictionary *dict in dataDict[@"car_list"]) {
            [arrM addObject:dict[@"img_path"]];
        }
        //        postCount--;
        //        if (postCount == 0) {
        //            [self loadData];
        //            [self.tableView reloadData];
        //        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"二手车图片资源请求失败%@",error);
    }];
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
    
    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadImage];
    }];
    [self.tableView.mj_header beginRefreshing];
    
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
    
    [cell.contentView addSubview:self.viewsArr[indexPath.section]];
    
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
