//
//  YWStoreViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWStoreViewController.h"
#import "YWUserViewController.h"
#import "ScanImageViewController.h"
#import "YWPublic.h"

@interface YWStoreViewController ()

@end

@implementation YWStoreViewController

#pragma mark 跳转到个人中心(tabBar实例调用)
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
