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

@interface YWProgressViewController () <ScanImageView>

@end

@implementation YWProgressViewController

#pragma mark 跳转到扫描二维码
- (void)pushToScanImageVC {
    [self presentViewController:[[ScanImageViewController alloc] init] animated:YES completion:nil];
}

#pragma mark 扫描结果输出代理
- (void)reportScanResult:(NSString *)result {
    
}

#pragma mark 跳转到个人中心
- (void)pushToUser:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[YWUserViewController alloc] init] animated:YES];
}

#pragma mark 选择城市
- (void)chooseCityAction {
    NSLog(@"home");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
