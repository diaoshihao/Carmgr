//
//  AboutViewController.m
//  Carmgr
//
//  Created by admin on 2016/11/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AboutViewController.h"
#import <Masonry.h>
#import "DefineValue.h"

typedef NS_ENUM(NSUInteger, LabelType) {
    TitleLabel,
    SubTitleLabel,
    VersionLabel,
};

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self showPage];
}

- (void)showPage {
    [self customLeftItem];
    [self deleteBlackLineFromNaviagtionBar];
    [self layoutViews];
}

- (void)customLeftItem {
    self.navigationItem.title = @"关于易务车宝";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退橙"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)deleteBlackLineFromNaviagtionBar {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage  alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)backToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutViews {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], 10)];
    separator.backgroundColor = [DefineValue separaColor];
    [self.view addSubview:separator];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"icon"];
    imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([DefineValue screenHeight] * 0.15);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *titleLabel = [self labelFor:TitleLabel text:@"易务车宝"];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(imageView);
    }];
    
    UILabel *subtitleLabel = [self labelFor:SubTitleLabel text:@"一站式爱车生活车主服务平台"];
    [self.view addSubview:subtitleLabel];
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(titleLabel);
    }];
    
    UILabel *versionLabel = [self labelFor:VersionLabel text:@"版本：1.1.0"];
    [self.view addSubview:versionLabel];
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subtitleLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(subtitleLabel);
    }];
}

- (UILabel *)labelFor:(LabelType)type text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    if (type == TitleLabel) {
        label.textColor = [DefineValue buttonColor];
        label.font = [DefineValue font16];
    } else if (type == SubTitleLabel) {
        label.textColor = [DefineValue fieldColor];
        label.font = [DefineValue font14];
    } else if (type == VersionLabel) {
        label.textColor = [DefineValue fieldColor];
        label.font = [DefineValue font12];
    } else {
        
    }
    return label;
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
