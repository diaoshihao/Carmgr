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
    viewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationVC.navigationBar.barTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    
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
    viewController.navigationItem.titleView = [self createSearchBarWithFrame:CGRectMake(0, 0, 0, 0) placeholder:@"输入商家、品类、商圈"];;
    
    //左item
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self chooseCityButtonWithTitle:@"广州" imageName:@"下拉" target:viewController]];
    
    //右item
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self scanImageAndUserWithTitle:nil userImage:@"个人中心" scanImage:@"二维码" target:viewController]];
}

#pragma mark - 自定义导航栏视图
#pragma mark 扫一扫和个人中心
- (UIView *)scanImageAndUserWithTitle:(NSString *)title userImage:(NSString *)userImage scanImage:(NSString *)scanImage target:(UIViewController *)target {
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    //扫一扫按钮
    UIButton *scanButton = [YWPublic createButtonWithFrame:CGRectMake(20, 10, 20, 20) title:title imageName:scanImage];
    //添加事件
    [scanButton addTarget:target action:@selector(pushToScanImageVC) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:scanButton];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightView).with.offset(0);
    }];
    
    //个人中心按钮
    UIButton *userButton = [YWPublic createButtonWithFrame:CGRectMake(50, 10, 20, 20) title:title imageName:userImage];
    //添加事件
    [userButton addTarget:target action:@selector(pushToUser:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:userButton];
    
    [userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView).with.offset(0);
    }];
    
    return rightView;
}

#pragma mark 选择城市按钮
- (UIView *)chooseCityButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(UIViewController *)viewController{
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    
    //城市按钮
    UIButton *button = [YWPublic createButtonWithFrame:CGRectMake(0, 15, 70, 10) title:title imageName:nil];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 10;
    //添加事件
    [button addTarget:viewController action:@selector(chooseCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftview addSubview:button];
    
    //箭头图标
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 15, 10, 10)];
    imageView.image = [YWPublic imageNameWithOriginalRender:imageName];
    imageView.backgroundColor = [UIColor clearColor];
    [leftview addSubview:imageView];
    return leftview;
}

#pragma mark 创建搜索栏
- (UIView *)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    view.backgroundColor = [UIColor clearColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.searchBar.placeholder = placeholder;
    [self.searchBar setImage:[UIImage imageNamed:@"搜索"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索栏"] forState:UIControlStateNormal];
    self.searchBar.delegate = self;
//    [view addSubview:self.searchBar];
//    return view;
    return self.searchBar;
}

- (void)chooseCityAction:(UIButton *)sender {
    NSLog(@"chooseCity");
}

#pragma mark - 搜索代理
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES];
}

//以下方法只是为了防止报出警告，具体实现在其他视图控制器中
- (void)pushToUser:(UIButton *)sender {
    
}

- (void)pushToScanImageVC {
    
}

@end
