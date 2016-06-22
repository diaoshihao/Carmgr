//
//  YWHomeViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWHomeViewController.h"
#import "YWUserViewController.h"
#import <SDCycleScrollView.h>

@interface YWHomeViewController () <SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation YWHomeViewController
{
    CGFloat width;          //轮播图宽度
    CGFloat height;         //轮播图高度
}

#pragma mark 轮播图
- (void)setCycleScrollView {
    
    
    NSArray *imageNameGroup = @[@"u10",@"u10"];         //图片名数组
    
    /**
     *  
     */
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, width, height) delegate:self placeholderImage:[UIImage imageNamed:@"u10"]];
    cycleScrollView.imageURLStringsGroup = imageNameGroup;
    cycleScrollView.autoScrollTimeInterval = 3.5;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:cycleScrollView];
    
}

#pragma mark 业务板块
- (void)setCollectionView {
    
}

#pragma mark 跳转到个人中心
- (void)pushToUser:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[YWUserViewController alloc] init] animated:YES];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    width = self.view.bounds.size.width;
    height = width / 2.5;
    
    [self setCycleScrollView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
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
