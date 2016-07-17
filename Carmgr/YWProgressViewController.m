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

@interface YWProgressViewController ()

@property (nonatomic, strong) ProgressView *progressView;

@end

@implementation YWProgressViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    
    self.progressView = [[ProgressView alloc] init];
    self.progressView.actionTarget = self;
    [self.progressView createTableView:self.view];
    [self loadData];

}

#pragma mark 加载网络数据
- (void)loadData {
    //参数
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *filter = [@"全部" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [YWPublic afPOST:[NSString stringWithFormat:kPROCESS,username,filter,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dataDict);
//        for (NSDictionary *dict in dataDict[@"merchants_list"]) {
//            StoreModel *model = [[StoreModel alloc] initWithDict:dict];
//            [self.storeView.dataArr addObject:model];
//        }
        
//        [self.progressView.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];

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
