//
//  NavigationAttribute.m
//  Carmgr
//
//  Created by admin on 16/6/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "NavigationAttribute.h"
#import "CustomNavigationController.h"
#import "YWPublic.h"

@interface  NavigationAttribute()

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation NavigationAttribute

#pragma mark -
#pragma mark 创建视图控制器
/**
 *  param:className 类名
 *  param:title     标签栏标题
 *  param:imageName 标签栏图标名
 */
- (UINavigationController *)createVCWithClass:(NSString *)className
                                        Title:(NSString *)title
                                        Image:(NSString *)imageName
                                  selectImage:(NSString *)selectImage {
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    CustomNavigationController *navigationVC = [[CustomNavigationController alloc] initWithRootViewController:viewController];
    
    //设置导航栏title和item
    [self navigationAttribute:viewController];
    
    //设置标签栏标题
    navigationVC.tabBarItem.title = title;
    [navigationVC.tabBarItem setImage:[YWPublic imageNameWithOriginalRender:imageName]];
    navigationVC.tabBarItem.selectedImage = [YWPublic imageNameWithOriginalRender:selectImage];
    return navigationVC;
}

#pragma mark 自定义导航栏title和item
- (void)navigationAttribute:(UIViewController *)viewController {
    viewController.navigationItem.titleView = [self createSearchBarWithFrame:CGRectMake(0, 0, 0, 0) placeholder:@"输入商家、品类、商圈"];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self chooseCityButtonWithTitle:@"广州" imageName:@"15_03"]];
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self scanImageAndUserWithTitle:nil userImage:@"个人" scanImage:@"二维码" target:viewController]];
}

#pragma mark - 自定义导航栏视图
#pragma mark 扫一扫和个人中心
- (UIView *)scanImageAndUserWithTitle:(NSString *)title userImage:(NSString *)userImage scanImage:(NSString *)scanImage target:(UIViewController *)target {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    //扫一扫按钮
    UIButton *button = [YWPublic createButtonWithFrame:CGRectMake(20, 10, 20, 20) title:title imageName:scanImage];
    //添加事件
    [button addTarget:self action:@selector(pushToUser:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    //个人中心按钮
    UIButton *button1 = [YWPublic createButtonWithFrame:CGRectMake(50, 10, 20, 20) title:title imageName:userImage];
    //添加事件
    [button1 addTarget:target action:@selector(pushToUser:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
    return view;
}

#pragma mark 选择城市按钮
- (UIView *)chooseCityButtonWithTitle:(NSString *)title imageName:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //城市按钮
    UIButton *button = [YWPublic createButtonWithFrame:CGRectMake(0, 10, 40, 20) title:title imageName:nil];
    //添加事件
    [button addTarget:self action:@selector(chooseCityAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    //箭头图标
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 10, 20, 20)];
    imageView.image = [YWPublic imageNameWithOriginalRender:imageName];
    imageView.backgroundColor = [UIColor clearColor];
    [view addSubview:imageView];
    return view;
}

#pragma mark 创建搜索栏
- (UISearchBar *)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    self.searchBar = [[UISearchBar alloc] initWithFrame:frame];
    self.searchBar.placeholder = placeholder;
    [self.searchBar setImage:[UIImage imageNamed:@"查看"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    return self.searchBar;
}

- (void)chooseCityAction {
    NSLog(@"chooseCity");
}

//该方法只是为了防止报出警告，具体实现在其他视图控制器中
- (void)pushToUser:(UIButton *)sender {
    
}

@end
