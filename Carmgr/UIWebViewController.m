//
//  UIWebViewController.m
//  Carmgr
//
//  Created by admin on 16/8/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [self createBarButtonItem:CGRectMake(0, 0, 60, 40)];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (UIBarButtonItem *)createBarButtonItem:(CGRect)frame {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = frame;
    [barButton setTitle:@"取消" forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    barButton.titleLabel.font = [UIFont systemFontOfSize:15];
    return item;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
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
