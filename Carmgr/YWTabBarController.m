//
//  YWTabBarController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWTabBarController.h"
#import "NavigationAttribute.h"

@interface YWTabBarController ()

@end

@implementation YWTabBarController



#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arrayTitle = @[@"首页",@"商家",@"进度",@"呼叫易宝"];
    NSArray *arrayImage = @[@"首页灰",@"商家灰",@"进度灰",@"电话灰"];
    NSArray *arraySelectImage = @[@"首页",@"商家",@"进度",@"电话"];
    NSArray *arrayClass = @[
                            @"YWHomeViewController",
                            @"YWStoreViewController",
                            @"YWProgressViewController",
                            @"YWCallViewController"];
    //存放视图控制器的数组
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    //创建视图控制器并添加到控制器数组
    for (NSInteger i = 0; i < 4; i++) {
        NavigationAttribute *navAttribute = [[NavigationAttribute alloc] init];
        [controllers addObject:[navAttribute createVCWithClass:arrayClass[i] Title:arrayTitle[i] Image:arrayImage[i] selectImage:arraySelectImage[i]]];
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
