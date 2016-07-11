//
//  UserCenterFunc.m
//  Carmgr
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UserCenterFunc.h"
#import "YWPublic.h"
#import <Masonry.h>
#import "AddCarCell.h"

@interface UserCenterFunc() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UIImageView   *userImageView;
@property (nonatomic, strong) UIButton      *userName;
@property (nonatomic, strong) UIButton      *messageButton;
@property (nonatomic, strong) UIButton      *settingButton;

@property (nonatomic, strong) NSArray       *titleArr;
@property (nonatomic, strong) NSArray       *imageArr;

@end

@implementation UserCenterFunc
{
    CGFloat width;      //屏幕宽
    CGFloat height;     //背景高
    CGFloat imageHeight;//头像长
    
}

- (NSArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = @[@[@""],@[@"账号余额"],@[@"个人资料",@"我的车辆"],@[@"历史业务",@"邮寄地址"]];
    }
    return _titleArr;
}
- (NSArray *)imageArr {
    if (_imageArr == nil) {
        _imageArr = @[@[@""],@[@"圆角矩形绿色"],@[@"圆角矩形深蓝",@"圆角矩形红色"],@[@"圆角矩形紫色",@"圆角矩形黄色"]];
    }
    return _imageArr;
}

- (UITableView *)createTableView:(UIView *)superView {
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = width / 2.5;
    imageHeight = height / 2;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [superView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(superView);
    }];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableHeaderView = [self createHeadView:self.actionTarget];
    
    return tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.titleArr[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [UIScreen mainScreen].bounds.size.width/2;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *normalID = @"normalcell";
    static NSString *unormalID = @"unormalcell";
    if (indexPath.section == 0) {
        AddCarCell *cell = [tableView dequeueReusableCellWithIdentifier:unormalID];
        if (cell == nil) {
            cell = [[AddCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unormalID];
        }
        [cell.button addTarget:self.actionTarget action:@selector(pushToAddCarInfo) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalID];
        }
        cell.textLabel.text = self.titleArr[indexPath.section][indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.section][indexPath.row]];
        return cell;
    }
    
}

- (void)pushToAddCarInfo {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",self.titleArr[indexPath.section][indexPath.row]);
}

- (UIView *)createHeadView:(id)target {
    
    //背景
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.headView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    
    //头像
    self.userImageView = [YWPublic createCycleImageViewWithFrame:CGRectZero image:@"头像大"];
    [self.headView addSubview:self.userImageView];
    
    //用户名
    self.userName = [YWPublic createButtonWithFrame:CGRectZero title:@"登录/注册" imageName:nil];
    [self.userName addTarget:target action:@selector(pushToLoginVC) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.userName];
    
    //信息
    self.messageButton = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:@"信封"];
    [self.headView addSubview:self.messageButton];
    
    //设置
    self.settingButton = [YWPublic createButtonWithFrame:CGRectZero title:nil imageName:@"设置"];
    [self.headView addSubview:self.settingButton];
    
    [self autoLayout];//自动布局
    
    return self.headView;
}

- (void)autoLayout {
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
        make.left.mas_equalTo(self.headView).with.offset(imageHeight/4);
        make.bottom.mas_equalTo(self.headView).with.offset(-imageHeight/4);
    }];

    [self.userName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).with.offset(imageHeight/4);
        make.centerY.mas_equalTo(self.userImageView);
    }];
    
    [self.messageButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.messageButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView).with.offset(imageHeight/4);
        make.right.mas_equalTo(self.headView).with.offset(-imageHeight/4);
    }];
    
    [self.settingButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.settingButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.messageButton.mas_left).with.offset(-imageHeight/4);
        make.centerY.mas_equalTo(self.messageButton);
    }];
}

- (void)pushToLoginVC {
    
}

@end
