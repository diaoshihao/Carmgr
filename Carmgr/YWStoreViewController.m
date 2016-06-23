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

#import "WJDropdownMenu.h"

@interface YWStoreViewController () <WJMenuDelegate>

@property (nonatomic,weak)WJDropdownMenu *menu;

@end

@implementation YWStoreViewController

#pragma mark 跳转到扫描二维码
- (void)pushToScanImageVC {
    [self presentViewController:[[ScanImageViewController alloc] init] animated:YES completion:nil];
}

#pragma mark 跳转到个人中心(tabBar实例调用)
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    menu.backgroundColor = [UIColor whiteColor];
    menu.delegate = self;         //  设置代理
    [self.view addSubview:menu];
    self.menu = menu;
    
    [self createAllMenuData];
    
}

- (void)createAllMenuData{
    NSArray *threeMenuTitleArray =  @[@"area"];
    
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"province1",@"province2", nil];
    
    NSArray *secondArrTwo = @[@[@"city1",@"city2"],@[@"B二级菜单21",@"B二级菜单22"]];
    
    NSArray *thirdArrTwo = @[@[@"B三级菜单11-1",@"B三级菜单11-2",@"B三级菜单11-3"],@[@"B三级菜单12-1",@"B三级菜单12-2"],@[@"B三级菜单21-1",@"B三级菜单21-2"],@[@"11111"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo,secondArrTwo,thirdArrTwo, nil];
    [self.menu createOneMenuTitleArray:threeMenuTitleArray FirstArray:secondMenu];
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
