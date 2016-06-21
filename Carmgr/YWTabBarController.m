//
//  YWTabBarController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWTabBarController.h"
#import "CustomNavigationController.h"
#import "YWHomeViewController.h"
#import "YWStoreViewController.h"
#import "YWProgressViewController.h"
#import "YWCallViewController.h"
#import "YWUserViewController.h"

@interface YWTabBarController ()

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation YWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    NSArray *arrayTitle = @[@"首页",@"商家",@"进度",@"呼叫易宝"];
    NSArray *arrayImage = @[@"u10",@"u10",@"u10",@"u10"];
    NSArray *arrayClass = @[
                            @"YWHomeViewController",
                            @"YWStoreViewController",
                            @"YWProgressViewController",
                            @"YWCallViewController"];
    //创建视图控制器并添加到标签栏
    for (NSInteger i = 0; i < 4; i++) {
        [controllers addObject:[self createVCWithClass:arrayClass[i] Title:arrayTitle[i] tabBarImage:arrayImage[i]]];
    }
    
    self.viewControllers = controllers;
}

#pragma mark 创建视图控制器
/**
 *  param:className 类名
 *  param:title     标签栏标题
 *  param:imageName 标签栏图标名
 */
- (UINavigationController *)createVCWithClass:(NSString *)className
                                Title:(NSString *)title
                          tabBarImage:(NSString *)imageName {
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    CustomNavigationController *navigationVC = [[CustomNavigationController alloc] initWithRootViewController:viewController];
    
    //设置导航栏属性
    [self navigationAttribute:viewController];
    
    //设置标签栏标题
    navigationVC.tabBarItem.title = title;
    return navigationVC;
}

- (void)navigationAttribute:(UIViewController *)viewController {
    viewController.navigationItem.titleView = [self createSearchBarWithFrame:CGRectMake(0, 0, 100, 20) placeholder:@"输入商家、品类、商圈"];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self customView:@"广州" imageName:@"u10" target:viewController]];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self customView:@"个人中心" imageName:@"u10" target:viewController]];
}

#pragma mark 自定义导航栏按钮视图
- (UIView *)customView:(NSString *)title imageName:(NSString *)imageName target:(UIViewController *)target {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 10, 60, 20);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:@selector(pushToUser:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 20, 20)];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    return view;
}

- (UISearchBar *)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    self.searchBar = [[UISearchBar alloc] initWithFrame:frame];
    self.searchBar.placeholder = placeholder;
    self.searchBar.layer.cornerRadius = 20;
    self.searchBar.layer.masksToBounds = YES;
    [self.searchBar setImage:[UIImage imageNamed:@"u10"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    return self.searchBar;
}

- (void)pushToUser:(UIButton *)sender {
    
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
