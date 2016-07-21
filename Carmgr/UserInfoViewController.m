//
//  UserInfoViewController.m
//  Carmgr
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"

@interface UserInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation UserInfoViewController

- (void)loadData {
    self.titleArr = @[@"头像",@"昵称",@"性别",@"所在地"];
    
    
    
}

- (void)customLeftItem {
    self.navigationItem.title = @"个人资料";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentMode = UIViewContentModeLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self customLeftItem];
    [self loadData];
    [self createTableView];
    
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UserInfoCell class] forCellReuseIdentifier:[UserInfoCell getReuseID]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserInfoCell getReuseID] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = self.titleArr[indexPath.row];
    [cell customViewAtRow:indexPath.row];
    if (indexPath.row == 0) {
        cell.headImageView.image = [UIImage imageNamed:@""];
    } else {
        cell.label.text = self.dataArr[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
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
