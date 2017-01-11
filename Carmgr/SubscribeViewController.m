//
//  SubscribeViewController.m
//  Carmgr
//
//  Created by admin on 2017/1/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "SubscribeViewController.h"
#import "DetailHeadView.h"
#import "Interface.h"
#import <Masonry.h>

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"业务预约";
    
    [self showPage];
}

- (void)showPage {
    [self configViews];
    [self configSubscribeView];
}

- (void)configViews {
    DetailHeadView *headView = [[DetailHeadView alloc] init];
    headView.img_path = self.serviceModel.service_img;
    headView.merchant_name = self.serviceModel.service_name;
    headView.stars = self.serviceModel.service_stars;
    headView.address = self.serviceModel.service_address;
    [self.view addSubview:headView];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.and.right.mas_equalTo(0);
    }];
    
}

- (void)configSubscribeView {
    CustomButton *button = [CustomButton buttonWithTitle:@"业务预约"];
    button.backgroundColor = [DefineValue mainColor];
    button.normalColor = [UIColor whiteColor];
    button.titleLabel.font = [DefineValue font16];
    [button addTarget:self action:@selector(willSubscribe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(50);
        make.left.and.right.mas_equalTo(0);
    }];
}

- (void)subscribe {
    NSArray *subscribe = [Interface appsubscribeservice_id:self.serviceModel.service_id merchant_id:self.merchant_id opt_type:@"0"];
    [MyNetworker POST:subscribe[InterfaceUrl] parameters:subscribe[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self showAlert:YES];
        } else {
            [self showAlert:NO];
        }
    } failure:^(NSError *error) {
        [self showAlert:NO];
    }];
}

- (void)willSubscribe {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否预约该业务？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self subscribe];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:sure];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)showAlert:(BOOL)success {
    NSString *message = @"发布成功！";
    if (success) {
        message = @"发布失败！";
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
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
