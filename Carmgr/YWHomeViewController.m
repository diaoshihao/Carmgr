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
#import "HomeTableViewCell.h"
#import "HomeView.h"

@interface YWHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HomeView *home;

@property (nonatomic, strong) NSMutableArray *heightArr;

@end

@implementation YWHomeViewController

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

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
}

- (void)initHeights {
    
}

- (void)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:[HomeTableViewCell reuseID]];
    
    self.home = [[HomeView alloc] init];
    self.home.imageArr = @[@"圆角矩形1",@"圆角矩形2",@"圆角矩形3",@"圆角矩形4",@"圆角矩形5",@"圆角矩形6",@"圆角矩形7",@"圆角矩形1",@"圆角矩形2",@"圆角矩形3"];
    self.home.titleArr = @[@"车险",@"上牌",@"车检",@"维修",@"驾考",@"保养",@"车贷",@"租车",@"二手",@"分类"];
    tableView.tableHeaderView = [self.home createCycleScrollView:@[@"u10",@"u10"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeTableViewCell reuseID]];
    
    [self.home createCollectionViewAtSuperView:cell];
    
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    NSLog(@"touch");
}

- (void)viewWillAppear:(BOOL)animated {
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
