//
//  YWProgressViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWProgressViewController.h"
#import "YWUserViewController.h"
#import "ScanImageViewController.h"
#import "YWPublic.h"
#import "ProgressView.h"
#import "ProgressModel.h"

@interface YWProgressViewController ()

@property (nonatomic, strong) ProgressView *progressView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YWProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    
    self.progressView = [[ProgressView alloc] init];
    self.progressView.actionTarget = self;
    self.tableView = [self.progressView createTableView:self.view];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self refresh];
}

//实现父类的方法，为本类提供刷新数据方法
- (void)refresh {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark 加载网络数据
- (void)loadData {
    //参数
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *filter = [@"全部" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //从数据库取出缓存
    if ([[YWDataBase sharedDataBase] isExistsDataInTable:@"tb_process"]) {
        self.progressView.dataArr = [[YWDataBase sharedDataBase] getAllDataFromProcess];
        [self.tableView reloadData];
    }
    
    NSString *urlStr = [NSString stringWithFormat:kPROCESS,username,filter,token];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            
            //插入数据库前删除数据
            [[YWDataBase sharedDataBase] deleteDatabaseFromTable:@"tb_process"];
            [self.progressView.dataArr removeAllObjects];
            
            for (NSDictionary *dict in dataDict[@"orders_list"]) {
                ProgressModel *model = [[ProgressModel alloc] initWithDict:dict];
                [self.progressView.dataArr addObject:model];
                
                //插入数据库
                [[YWDataBase sharedDataBase] insertProcessWithModel:model];
            }
            [self.progressView.tableView reloadData];
            if (self.progressView.dataArr.count == 0) {//订单数为0
                [self showAlertView];
            }
            
        } else {
            [YWPublic pushToLogin:self];
            /*
            UIAlertController *alertVC = [YWPublic showReLoginAlertViewAt:self];
            [self presentViewController:alertVC animated:YES completion:nil];
            */
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        UIAlertController *alertVC = [YWPublic showFaileAlertViewAt:self];
        [self presentViewController:alertVC animated:YES completion:nil];
    }];

}

- (void)showAlertView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂未能获取到您的订单信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//进度点击action
- (void)buttonClick:(UIButton *)sender {
    
    if (sender.isSelected) {
        NSLog(@"selected");
    } else {
        for (NSInteger i = 0; i <= 6; i++) {
            UIButton *button = (UIButton *)[self.view viewWithTag:1000+i];
            button.selected = NO;
        }
        sender.selected = YES;
    }
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
