//
//  YWTabBarController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWTabBarController.h"

@interface YWTabBarController () 

@end

@implementation YWTabBarController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.translucent = NO;
    [self createViews];
    
}

//改变tabbar高度
//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.size.height = 49;
//    tabFrame.origin.y = self.view.frame.size.height - 49;
//    self.tabBar.frame = tabFrame;
//}

- (void)createViews {
    
    NSArray *arrayTitle = @[@"首页",@"商家",@"附近",@"我的"];
    NSArray *arrayImage = @[@"首页",@"商家",@"进度",@"我的"];
    NSArray *arraySelectImage = @[@"首页橙",@"商家橙",@"进度橙",@"我的橙"];
    NSArray *arrayClass = @[
                            @"YWHomeViewController",
                            @"MerchantViewController",
                            @"NearByViewController",
                            @"YWUserViewController"];
    
    //存放视图控制器的数组
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 4; i++) {
        UIViewController *viewController = [[NSClassFromString(arrayClass[i]) alloc] init];
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationVC.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        
        //设置标签栏
        navigationVC.tabBarItem.title = arrayTitle[i];
        [navigationVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:178/256.0 green:178/256.0 blue:178/256.0 alpha:1]} forState:UIControlStateNormal];
        [navigationVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0]} forState:UIControlStateSelected];
        [navigationVC.tabBarItem setImage:[[UIImage imageNamed:arrayImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        navigationVC.tabBarItem.selectedImage = [[UIImage imageNamed:arraySelectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //修改item文字大小和位置
        [navigationVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
        
        [controllers addObject:navigationVC];
    }
    
    self.viewControllers = controllers;
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
