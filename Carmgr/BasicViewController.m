//
//  BasicViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *stateView;

@property (nonatomic, strong) UIView *shadow;

@end

@implementation BasicViewController

- (void)setTitle:(NSString *)title {
    self.barTitleLabel.text = title;
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.stateView.backgroundColor = backColor;
    self.customNavBar.backgroundColor = backColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [DefineValue separaColor];
    self.navigationController.navigationBarHidden = YES;
    [self customNavigationBar];
    [self configLeftItemView];
    [self configRightItemView];
}

- (void)customNavigationBar {
    self.stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], 20)];
    self.stateView.backgroundColor = [DefineValue mainColor];
    [self.view addSubview:self.stateView];
    self.customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [DefineValue screenWidth], 44)];
    self.customNavBar.backgroundColor = [DefineValue mainColor];
    [self.view addSubview:self.customNavBar];
    
    self.barTitleLabel = [[UILabel alloc] init];
    self.barTitleLabel.font = [UIFont systemFontOfSize:18];
    [self.customNavBar addSubview:self.barTitleLabel];
    [self.barTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.customNavBar);
    }];
    
    [self.view bringSubviewToFront:self.stateView];
    [self.view bringSubviewToFront:self.customNavBar];
}

- (void)configLeftItemView {
    
}
- (void)configRightItemView {
    
}

- (void)showShadowLine:(BOOL)showShadow {
    if (!showShadow) {
        return;
    }
    self.shadow = [[UIView alloc] init];
    self.shadow.backgroundColor = [DefineValue mainColor];
    [self.customNavBar addSubview:self.shadow];
    [self.shadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue pixHeight]);
    }];
}

- (void)setShowShadow:(BOOL)showShadow {
    _showShadow = showShadow;
    [self showShadowLine:showShadow];
}

- (void)setShadowColor:(UIColor *)color {
    if (_showShadow == NO) {
        self.showShadow = YES;
    }
    self.shadow.backgroundColor = color;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
