//
//  SecondaryViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "SecondaryViewController.h"
#import "CustomButton.h"

@interface SecondaryViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation SecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backColor = [UIColor whiteColor];
}

- (void)configLeftItemView {
    self.leftItemButton = [CustomButton buttonWithImage:@"后退橙"];
    [self.leftItemButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.leftItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.leftItemButton.titleLabel.font = [DefineValue font16];
    [self.customNavBar addSubview:self.leftItemButton];
    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
}

- (void)configRightItemView {
    
}

#pragma mark - 右滑返回上一页
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    //滑动返回
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    //滑动返回
    [super viewDidDisappear:YES];
    self.navigationController.delegate = nil;
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
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
