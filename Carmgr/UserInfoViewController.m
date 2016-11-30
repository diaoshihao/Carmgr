//
//  UserInfoViewController.m
//  Carmgr
//
//  Created by admin on 16/7/19.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCell.h"
#import "PrivateModel.h"
#import "YWDataBase.h"

@interface UserInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PrivateModel *privateModel;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation UserInfoViewController

- (PrivateModel *)privateModel {
    if (_privateModel == nil) {
        _privateModel = [[[YWDataBase sharedDataBase] getAllDataFromPrivate] firstObject];
    }
    return _privateModel;
}

- (void)loadData {
    self.titleArr = @[@"头像",@"昵称",@"性别",@"所在地"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.view.backgroundColor = [DefineValue separaColor];
    
    [self loadData];
    [self createTableView];
    
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [DefineValue screenWidth], [DefineValue screenHeight] - 70) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [DefineValue separaColor];
    tableView.scrollEnabled = NO;
    
    [tableView registerClass:[UserInfoCell class] forCellReuseIdentifier:[UserInfoCell getReuseID]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [DefineValue separaColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[UserInfoCell getReuseID] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell customViewAtRow:indexPath.row];
    
    cell.titleLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.headImageView.image = self.headImage;
    } else if (indexPath.row == 1) {
        cell.label.text = self.privateModel.username;
    } else if (indexPath.row == 2) {
        if (self.privateModel.sex != nil) {
            cell.label.text = self.privateModel.sex;
        } else {
            cell.label.text = @"男";
        }
    } else if (indexPath.row == 3) {
        if (self.privateModel.city != nil) {
            cell.label.text = self.privateModel.city;
        } else {
            cell.label.text = @"广州";
        }
    } else;
    
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
