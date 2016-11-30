//
//  BalanceViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BalanceViewController.h"
#import "BalanceView.h"

@interface BalanceViewController ()

@property (nonatomic, strong) BalanceView *balanceView;

@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户余额";
    [self showPage];
}

- (void)showPage {
    [self initRightButton];
    [self initView];
}

- (void)initRightButton {
    self.rightItemButton = [self buttonWithTitle:@"收入明细"];
    [self.rightItemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)initView {
    self.balanceView = [[BalanceView alloc] init];
    self.balanceView.balance = 1000;
    __weak typeof(self) weakSelf = self;
    self.balanceView.buttonClick = ^(Balance balance) {
        [weakSelf pushToPage:balance];
    };
    [self.view addSubview:self.balanceView];
    [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
    }];
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    return button;
}

- (void)buttonClick:(UIButton *)sender {
    
}

//跳转到相应页面
- (void)pushToPage:(Balance )balance {
    
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
