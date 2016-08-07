//
//  ViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "BaseViewController.h"
#import <Masonry.h>
#import "YWUserViewController.h"
#import "ScanImageViewController.h"
#import "UIWebViewController.h"

@interface BaseViewController () <ScanImageView>

@end

@implementation BaseViewController
{
    UIImageView *cityImage;
    UIButton *scanButton;
}

- (void)refresh {
    //刷新数据，交给子类去实现
    //解决不同页面由于token失效等原因需要登录后返回刷新
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;   
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createCustomBar];
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [self.view addGestureRecognizer:tap];
    
}
- (void)hideSearchBar:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)createCustomBar {
    
    UIView *statView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    statView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    [self.view addSubview:statView];
    
    self.customBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    self.customBar.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    [self.view addSubview:self.customBar];
    
    [self customNavigationBar];
}

- (void)customNavigationBar {
    
    
    //左item
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"广州" forKey:@"city"];
    }
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    [self chooseCityButtonWithTitle:city imageName:@"下拉"];
    
    //右item
    [self scanImageAndUserWithTitle:nil userImage:@"个人中心" scanImage:@"二维码"];
    
    [self createSearchBarWithFrame:CGRectMake(0, 0, 255, 44) placeholder:@"输入商品或服务"];
}

#pragma mark - 自定义导航栏视图
#pragma mark 扫一扫和个人中心
- (void)scanImageAndUserWithTitle:(NSString *)title userImage:(NSString *)userImage scanImage:(NSString *)scanImage {
    
    //个人中心按钮
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userButton setBackgroundImage:[UIImage imageNamed:userImage] forState:UIControlStateNormal];
    //添加事件
    [userButton addTarget:self action:@selector(pushToUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.customBar addSubview:userButton];
    
    [userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.customBar).with.offset(-20);
        make.centerY.mas_equalTo(self.customBar);
//        make.bottom.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(19, 21));
    }];
    
    //扫一扫按钮
    scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setBackgroundImage:[UIImage imageNamed:scanImage] forState:UIControlStateNormal];
    //添加事件
    [scanButton addTarget:self action:@selector(pushToScanImageVC) forControlEvents:UIControlEventTouchUpInside];
    [self.customBar addSubview:scanButton];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(userButton.mas_left).with.offset(-15);
        make.centerY.mas_equalTo(self.customBar);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
}

#pragma mark 选择城市按钮
- (void)chooseCityButtonWithTitle:(NSString *)title imageName:(NSString *)imageName {

    //城市按钮
    self.cityChoose = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cityChoose setTitle:title forState:UIControlStateNormal];
    [self.cityChoose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cityChoose.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //添加事件
    [self.cityChoose addTarget:self action:@selector(chooseCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customBar addSubview:self.cityChoose];
    
    [self.cityChoose setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.cityChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.customBar).with.offset(20);
        make.centerY.mas_equalTo(self.customBar);
    }];
    
    
    //箭头图标
    cityImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    cityImage.image = [YWPublic imageNameWithOriginalRender:imageName];
    cityImage.backgroundColor = [UIColor clearColor];
    [self.customBar addSubview:cityImage];
    
    [cityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cityChoose.mas_right).with.offset(5);
        make.centerY.mas_equalTo(self.customBar);
    }];
}

#pragma mark 创建搜索栏
- (void)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.barStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = placeholder;
    
    //取出textfield
    UITextField *searchField=[self.searchBar valueForKey:@"_searchField"];
    searchField.font = [UIFont systemFontOfSize:12];
    [searchField setValue:[UIColor colorWithRed:204/256.0 green:204/256.0 blue:204/256.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索栏"] forState:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"搜索"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    self.searchBar.tintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    self.searchBar.barTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
    [self.customBar addSubview:self.searchBar];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cityImage.mas_right).with.offset(5);
        make.right.mas_equalTo(scanButton.mas_left).with.offset(-5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
//        make.centerY.mas_equalTo(self.customBar);
    }];
    
}

#pragma mark 跳转到个人中心
- (void)pushToUser:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[YWUserViewController alloc] init] animated:YES];
}

#pragma mark 选择城市
- (void)chooseCityAction:(UIButton *)sender {
    CityChooseViewController *cityChooseVC = [[CityChooseViewController alloc] init];
    [cityChooseVC returnCityInfo:^(NSString *province, NSString *area, NSArray *areaList) {
        
        [[NSUserDefaults standardUserDefaults] setObject:area forKey:@"city"];
        [[NSUserDefaults standardUserDefaults] setObject:areaList forKey:@"areaList"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isChangeCity"];
    }];
    [self.navigationController pushViewController:cityChooseVC animated:YES];
}

#pragma mark 跳转到扫描二维码
- (void)pushToScanImageVC {
    
     ScanImageViewController *scanImageVC = [[ScanImageViewController alloc] init];
     scanImageVC.delegate = self;
     [self presentViewController:scanImageVC animated:YES completion:nil];    
}

#pragma mark 扫描结果输出代理
- (void)reportScanResult:(NSString *)result {
    UIWebViewController *webViewVC = [[UIWebViewController alloc] init];
    webViewVC.urlStr = result;
    UINavigationController *webNav = [[UINavigationController alloc] initWithRootViewController:webViewVC];
    [self presentViewController:webNav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.cityChoose setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"city"] forState:UIControlStateNormal];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
