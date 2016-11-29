//
//  MessageViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewController.h"
#import "MessageModel.h"

@interface MessageViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"系统消息";
    [self showPage];
}

- (void)showPage {
    [self loadData];
    [self initTableView];
}

- (void)loadData {
    NSDictionary *dict = @{@"title":@"易务车宝V1.1在线升级啦",@"time":@"10月15日",@"imageUrl":@"呼叫背景",@"subTitle":@"赶快看看我们更新了什么吧"};
    MessageModel *model = [[MessageModel alloc] initWithDict:dict];
    self.dataArr = [NSMutableArray arrayWithObjects:model, model, nil];
}

- (void)initTableView {
    MessageTableViewController *messageTVC = [[MessageTableViewController alloc] init];
    messageTVC.dataArr = self.dataArr;
    [self addChildViewController:messageTVC];
    UITableView *tableView = messageTVC.tableView;
    tableView.frame = CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64);
    [self.view addSubview:tableView];
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
