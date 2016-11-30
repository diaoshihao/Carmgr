//
//  SettingViewController.m
//  Carmgr
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "SettingViewController.h"
#import <Masonry.h>
#import "ServiceDelegateController.h"
#import "YWLoginViewController.h"
#import "AboutViewController.h"

@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)customLeftItem {
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退橙"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlertViewTitle:(NSString *)title messae:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVC animated:YES completion:^{
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timerFireMethod:) userInfo:alertVC repeats:NO];
    }];
}

#pragma mark 定时器
- (void)timerFireMethod:(NSTimer *)timer {
    UIAlertController *alertVC = [timer userInfo];
    [alertVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self customLeftItem];
    self.title = @"设置";
    
    self.dataArr = @[@[@"移动网络下载图片",@"清理缓存"],@[@"关于我们",@"招商信息",@"给个好评"],@[@"使用帮助",@"用户协议"],@[@"退出登录"]];
    
    [self createTableView];
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64) style:UITableViewStyleGrouped];
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"settingcell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingcell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *netSwitch = [[UISwitch alloc] init];
        netSwitch.onTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
        
        netSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"MONET"];//是否在移动网络下载图片
        [netSwitch addTarget:self action:@selector(setSwitchOn:) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:netSwitch];
        
        [netSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(cell.contentView);
        }];
    }
    
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 3) {//退出登录cell
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"] == NO) {
            cell.userInteractionEnabled = NO;
            cell.backgroundColor = [UIColor colorWithRed:204/256.0 green:204/256.0 blue:204/256.0 alpha:1];
        }
    }
    return cell;
}

- (void)setSwitchOn:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"MONET"];
    if (sender.on) {
        NSLog(@"on");
    } else {
        NSLog(@"off");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {//清理缓存
        [self clear];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1144300873"]];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        ServiceDelegateController *delegateVC = [[ServiceDelegateController alloc] init];
        [self.navigationController pushViewController:delegateVC animated:YES];
    }
    
    if (indexPath.section == 3) {
        [self logout];
    }
}

- (void)clear {
    NSArray *tableArr = @[@"tb_store",@"tb_process"];
    BOOL result = NO;
    for (NSString *tb_name in tableArr) {
        result = [[YWDataBase sharedDataBase] deleteDatabaseFromTable:tb_name];
        if (result == NO) {
            break;
        }
    }
    if (result == NO) {
        [self showAlertViewTitle:nil messae:@"清理缓存失败"];
    } else {
        [self showAlertViewTitle:nil messae:@"清理缓存成功"];
    }
}

- (void)logout {
    //退出登录，取消登录状态
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    UIViewController *loginVC = [[YWLoginViewController alloc] init];
    UINavigationController *navigaVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigaVC animated:YES completion:nil];
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
