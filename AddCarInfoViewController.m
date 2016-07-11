//
//  CarVerifyViewController.m
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AddCarInfoViewController.h"
#import "AddCarInfoCell.h"
#import "AddCarInfoView.h"
#import <Masonry.h>

@interface AddCarInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *viewsArr;

@property (nonatomic, strong) AddCarInfoView *infoView;

@end

@implementation AddCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    
    [self customLeftItem];
    
    self.infoView = [[AddCarInfoView alloc] init];
    self.infoView.target = self;
    self.infoView.superView = self.view;
    
    self.viewsArr = @[[self.infoView numberType],[self.infoView createLabelAndButton:nil]];
    
    self.titleArr = @[@[@"号码类型",@"车        型"],@[@"查询城市"],@[@"车牌号码",@"发动机号",@"车架号码"],@[@"保险进保日期",@"首次保养日期",@"行驶公里数"],@[@"备        注"]];
    
    //view
    [self createTableView];
    
}

- (void)customLeftItem {
    self.navigationItem.title = @"添加车辆";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentMode = UIViewContentModeLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backToLastPage {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[AddCarInfoCell class] forCellReuseIdentifier:[AddCarInfoCell getReuseID]];
    
    //button
    UIButton *button = [self.infoView createLabelAndButton:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(button.mas_top).with.offset(-20);
    }];
}

- (void)checkCarInfo {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddCarInfoCell getReuseID] forIndexPath:indexPath];
    if ((indexPath.section == 0 && indexPath.row == 1) || (indexPath.section == 1) || (indexPath.section == 4)) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.titleLabel.text = self.titleArr[indexPath.section][indexPath.row];
    cell.backView = self.viewsArr[indexPath.section%2];
    NSLog(@"%@",cell.subviews);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
