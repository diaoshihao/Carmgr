//
//  AppealViewController.m
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "AppealViewController.h"
#import "AppealTableViewController.h"

@interface AppealViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AppealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"求助订单";
    [self configSubviews];
}

- (void)configSubviews {
    AppealTableViewController *appealTVC = [[AppealTableViewController alloc] init];
    [self addChildViewController:appealTVC];
    self.tableView = appealTVC.tableView;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
}

- (void)configRightItemView {
    self.rightItemButton = [CustomButton buttonWithTitle:@"发布求助"];
    [self.rightItemButton setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    self.rightItemButton.titleLabel.font = [DefineValue font14];
    [self.rightItemButton addTarget:self action:@selector(subscribe) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.customNavBar);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
}

- (void)subscribe {
    
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
