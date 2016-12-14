//
//  MyFavouriteViewController.m
//  Carmgr
//
//  Created by admin on 2016/12/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MyFavouriteViewController.h"
#import "MyFavouriteTableViewCell.h"
#import "MyFavouriteModel.h"
#import "YWPublic.h"

@interface MyFavouriteViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MyFavouriteViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的收藏";
    [self configView];
//    [self loadData];
}

- (void)loadData {
    MyFavouriteModel *model = [[MyFavouriteModel alloc] initWithDict:@{@"img_path":@"http://112.74.13.51:8080/carmgr/upload/image/secondhandcar/esc_1.jpg",@"service_name":@"test_name",@"merchant_name":@"test_name",@"price":@"100"}];
    [self.dataArr addObjectsFromArray:@[model,model,model]];
    [self.tableView reloadData];
}

- (void)configView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 132;
    self.tableView.backgroundColor = [DefineValue separaColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyFavouriteTableViewCell class] forCellReuseIdentifier:@"MyFavouriteTableViewCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(70, 0, 0, 0));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFavouriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyFavouriteTableViewCell" forIndexPath:indexPath];
    MyFavouriteModel *model = self.dataArr[indexPath.section];
    [YWPublic loadWebImage:model.img_path didLoad:^(UIImage * _Nonnull image) {
        cell.headImageView.image = image;
    }];
    cell.serviceName.text = model.service_name;
    cell.merchantName.text = model.merchant_name;
    cell.price.text = [NSString stringWithFormat:@"%@元／单",model.price];
    [cell collectionAction:^(CollectionAction action) {
        if (action == CollectionActionCancel) {
            [self deleteCurrent:indexPath];
        } else if (action == CollectionActionAppoint) {
            [self appointCurrent:indexPath];
        } else {
            [self shareCurrent:indexPath];
        }
    }];
    return cell;
}

//取消收藏
- (void)deleteCurrent:(NSIndexPath *)indexPath {
    [self.dataArr removeObjectAtIndex:indexPath.section];
    [self.tableView reloadData];
}

//预约
- (void)appointCurrent:(NSIndexPath *)indexPath {
    
}

//分享
- (void)shareCurrent:(NSIndexPath *)indexPath {
    
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
