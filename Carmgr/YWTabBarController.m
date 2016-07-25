//
//  YWTabBarController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWTabBarController.h"
#import "ScanImageViewController.h"
#import "YWPublic.h"

@interface YWTabBarController () 

@end

@implementation YWTabBarController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViews];
    self.tabBar.translucent = NO;
}

- (void)createViews {
    
    NSArray *arrayTitle = @[@"首页",@"商家",@"进度",@"呼叫易宝"];
    NSArray *arrayImage = @[@"首页",@"商家",@"进度",@"呼叫易宝"];
    NSArray *arraySelectImage = @[@"首页橙",@"商家橙",@"进度橙",@"呼叫易宝橙"];
    NSArray *arrayClass = @[
                            @"YWHomeViewController",
                            @"YWStoreViewController",
                            @"YWProgressViewController",
                            @"YWCallViewController"];
    
    //存放视图控制器的数组
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 4; i++) {
        UIViewController *viewController = [[NSClassFromString(arrayClass[i]) alloc] init];
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        //设置标签栏
        navigationVC.tabBarItem.title = arrayTitle[i];
        [navigationVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0]} forState:UIControlStateSelected];
        [navigationVC.tabBarItem setImage:[YWPublic imageNameWithOriginalRender:arrayImage[i]]];
        navigationVC.tabBarItem.selectedImage = [YWPublic imageNameWithOriginalRender:arraySelectImage[i]];
        
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
