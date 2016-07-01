//
//  NavigationAttribute.m
//  Carmgr
//
//  Created by admin on 16/6/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "NavigationAttribute.h"
#import "YWPublic.h"
#import <Masonry.h>

@interface  NavigationAttribute() <UISearchBarDelegate>

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
    viewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationVC.navigationBar.barTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    navigationVC.navigationBar.tintColor = [UIColor whiteColor];
    
    //设置导航栏title和item
    [self navigationAttribute:viewController];
    
    //设置标签栏标题
    navigationVC.tabBarItem.title = title;
    [navigationVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0]} forState:UIControlStateSelected];
    [navigationVC.tabBarItem setImage:[YWPublic imageNameWithOriginalRender:imageName]];
    navigationVC.tabBarItem.selectedImage = [YWPublic imageNameWithOriginalRender:selectImage];
    return navigationVC;
}

#pragma mark 自定义导航栏title和item
- (void)navigationAttribute:(UIViewController *)viewController {
    
    //标题
    viewController.navigationItem.titleView = [self createSearchBarWithFrame:CGRectMake(0, 0, 0, 0) placeholder:@"输入商家、品类、商圈"];
    
    //左item
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"广州" forKey:@"city"];
    }
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self chooseCityButtonWithTitle:city imageName:@"下拉" target:viewController]];
    
    //右item
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self scanImageAndUserWithTitle:nil userImage:@"个人中心" scanImage:@"二维码" target:viewController]];
}

#pragma mark - 自定义导航栏视图
#pragma mark 扫一扫和个人中心
- (UIView *)scanImageAndUserWithTitle:(NSString *)title userImage:(NSString *)userImage scanImage:(NSString *)scanImage target:(UIViewController *)target {
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //个人中心按钮
    UIButton *userButton = [YWPublic createButtonWithFrame:CGRectZero title:title imageName:userImage];
    //添加事件
    [userButton addTarget:target action:@selector(pushToUser:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:userButton];
    
    [userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView).with.offset(0);
        make.centerY.mas_equalTo(rightView);
    }];
    
    //扫一扫按钮
    UIButton *scanButton = [YWPublic createButtonWithFrame:CGRectZero title:title imageName:scanImage];
    //添加事件
    [scanButton addTarget:target.tabBarController action:@selector(pushToScanImageVC) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:scanButton];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(userButton.mas_left).with.offset(-15);
        make.centerY.mas_equalTo(rightView);
    }];
    
    return rightView;
}

#pragma mark 选择城市按钮
- (UIView *)chooseCityButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(UIViewController *)viewController{
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //城市按钮
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:title imageName:nil];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 10;
    //添加事件
    [button addTarget:viewController action:@selector(chooseCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftview addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftview).with.offset(0);
        make.centerY.mas_equalTo(leftview);
    }];
    
    //箭头图标
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [YWPublic imageNameWithOriginalRender:imageName];
    imageView.backgroundColor = [UIColor clearColor];
    [leftview addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button.mas_right).with.offset(5);
        make.centerY.mas_equalTo(leftview);
    }];
    
    self.cityButton = button;
    
    return leftview;
}

#pragma mark 创建搜索栏
- (UISearchBar *)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    view.backgroundColor = [UIColor clearColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    searchBar.placeholder = placeholder;
    [searchBar setImage:[UIImage imageNamed:@"搜索"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索栏"] forState:UIControlStateNormal];
    searchBar.delegate = self;
//    [view addSubview:self.searchBar];
//    return view;
    return searchBar;
}


#pragma mark - 搜索代理
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self endEditing:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    return YES;
}

//以下方法只是为了防止报出警告，具体实现在其他视图控制器中
- (void)pushToUser:(UIButton *)sender {
    
}

- (void)chooseCityAction:(UIButton *)sender {
    
}

- (void)pushToScanImageVC {
    
}

@end
