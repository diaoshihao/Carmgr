//
//  ForHelpViewController.m
//  Carmgr
//
//  Created by admin on 2017/2/7.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "ForHelpViewController.h"
#import "ForHelpTableViewController.h"

@interface ForHelpViewController ()

@end

@implementation ForHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布求助";
    self.showShadow = YES;
    [self configViews];
}

- (void)configViews {
    ForHelpTableViewController *forHelpTVC = [[ForHelpTableViewController alloc] init];
    [self addChildViewController:forHelpTVC];
    UITableView *tableView = forHelpTVC.tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
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
