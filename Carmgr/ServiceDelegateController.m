//
//  ServiceDelegateController.m
//  Carmgr
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceDelegateController.h"

@interface ServiceDelegateController ()

@end

@implementation ServiceDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"服务协议";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.editable = NO;
    [self.view addSubview:textView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"服务协议" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    textView.text = text;
    
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
