//
//  YWCallViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWCallViewController.h"
#import "YWPublic.h"

@interface YWCallViewController ()

@end

@implementation YWCallViewController

- (void)callAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"呼叫易宝" message:@"呼叫易宝可为您提供即时咨询" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *call = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self callAction];
    }];
    [alertController addAction:cancel];
    [alertController addAction:call];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)callAction {
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:18218456285"]]];
    [self.view addSubview:callWebview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *callButton = [YWPublic createButtonWithFrame:CGRectMake(100, 100, 100, 30) title:@"呼叫易宝" imageName:nil];
    [callButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(callAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    
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
