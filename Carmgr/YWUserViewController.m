//
//  YWUserViewController.m
//  Carmgr
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWUserViewController.h"

#import "YWLoginViewController.h"
#import "SettingViewController.h"
#import "BalanceViewController.h"
#import "MessageViewController.h"
#import "UserInfoViewController.h"
#import "UserTableViewController.h"
#import "AddCarInfoViewController.h"
#import "YWProgressViewController.h"
#import "MyFavouriteViewController.h"

#import "MyCarView.h"
#import "MyOrderView.h"
#import "UserHeadView.h"

#import "Interface.h"
#import "AlertShowAssistant.h"

@interface YWUserViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UserHeadView *headView;
@property (nonatomic, strong) MyCarView *carView;
@property (nonatomic, strong) MyOrderView *orderView;

@end

@implementation YWUserViewController

//检查用户是否添加过车辆
- (void)getCarInfo {
    NSArray *getCarInfo = [Interface appgetcarinfo];
    [MyNetworker POST:getCarInfo[InterfaceUrl] parameters:getCarInfo[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"] && [responseObject[@"list_size"] integerValue] != 0) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            self.carView.infoModel = [[CarInfoModel alloc] initWithDict:dict];
            
            self.carView.hasCar = YES;
            
        } else {
            self.carView.hasCar = NO;
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadData {
    NSArray *private = [Interface appgetprivate];
    [MyNetworker POST:private[InterfaceUrl] parameters:private[Parameters] success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self showPage];
    
    if ([self isLogin]) {
        [self getCarInfo];
    }
    
    [self loadData];
}

- (void)showPage {
    [self initContentView];
    [self myHeadView];
    [self myOrderView];
    [self myCarView];
    [self tableView];
}

- (void)initContentView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [DefineValue separaColor];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo([DefineValue screenWidth]);
    }];
}

- (void)myHeadView {
    self.headView = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], [DefineValue screenWidth] / 2.5)];
    __weak typeof(self) weakSelf = self;
    self.headView.buttonClick = ^(ClickAtButton buttonType) {
        [weakSelf headViewDidClick:buttonType];
    };
    [self.contentView addSubview:self.headView];
}


- (void)myOrderView {
    self.orderView = [[MyOrderView alloc] init];
    [self.orderView didClickOrder:^(MyOrderOption option) {
        if ([self isLogin]) {
            if (option == MyOrderOptionService) {
                [self pushToProgress];
            } else {
                [self pushToHelpOrder];
            }
        } else {
            [self showAlert];
        }
    }];
    [self.contentView addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(108);
    }];
}

- (void)myCarView {
    self.carView = [[MyCarView alloc] init];
    [self.carView beginMyCarAction:^(MyCarAction action) {
        if ([self isLogin]) {
            [self pushToAddCarInfo];
        } else {
            [self showAlert];
        }

    }];
    [self.contentView addSubview:self.carView];
    [self.carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderView.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
    }];
}


- (void)tableView {
    
    UserTableViewController *userTableVC = [[UserTableViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    userTableVC.cellDidSelect = ^(NSIndexPath *indexPath) {
        [weakSelf tableViewCellDidSelect:indexPath];
    };
    [self addChildViewController:userTableVC];
    [self.contentView addSubview:userTableVC.tableView];
    [userTableVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44 * 5 + 16);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

- (void)headViewDidClick:(ClickAtButton)buttonType {
    switch (buttonType) {
        case ButtonUserName:
            if ([self isLogin]) {
                [self pushToUserInfo];
            } else {
                [self pushToLoginVC];
            }
            break;
        case ButtonMessage:
            [self pushToMessagePage];
            break;
        case ButtonSetting:
            [self pushToSettingPage];
            break;
            
        default:
            break;
    }
}

- (void)tableViewCellDidSelect:(NSIndexPath *)indexPath {
    if ([self isLogin]) {
        if (indexPath.section == 0) {
            [self pushToMyBalance];
        } else {
            switch (indexPath.row) {
                case 0:
                    [self pushToMyFavourite];
                    break;
                case 1:
                    [self pushToUserInfo];
                    break;
                case 2:
                    [self pushToMyHistory];
                    break;
                case 3:
                    [self pushToMyAddress];
                    break;
                    
                default:
                    break;
            }
        }
    } else {
        [self showAlert];
    }
}

- (void)showAlert {
    [AlertShowAssistant alertTip:@"请登录" message:@"是否前往登录" actionTitle:@"登录" defaultHandle:^{
        [self pushToLoginVC];
    } cancelHandle:^{
        
    }];
}

#pragma mark - 跳转界面
#pragma mark 跳转到登录界面
- (void)pushToLoginVC {
    UIViewController *loginVC = [[YWLoginViewController alloc] init];
    UINavigationController *navigaVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigaVC animated:YES completion:nil];
}

#pragma mark 跳转到添加车辆界面
- (void)pushToAddCarInfo {
    AddCarInfoViewController *addCarInfo = [[AddCarInfoViewController alloc] init];
    //用户添加车辆成功，显示车辆信息
    [addCarInfo addCarInfoSuccessful:^{
        [self getCarInfo];
    }];
    addCarInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addCarInfo animated:YES];
}

#pragma mark 跳转到消息界面
- (void)pushToMessagePage {
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

#pragma mark 跳转到设置界面
- (void)pushToSettingPage {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    //用户退出登录，不显示车辆信息
    [settingVC userLogout:^{
        self.carView.hasCar = NO;
    }];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark 跳转到个人资料界面
- (void)pushToUserInfo {
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.headImage = self.headView.userImageView.currentImage;
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

#pragma mark 跳转到账号余额界面
- (void)pushToMyBalance {
    BalanceViewController *balanceVC = [[BalanceViewController alloc] init];
    balanceVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:balanceVC animated:YES];
}

#pragma mark 跳转到我的收藏界面
- (void)pushToMyFavourite {
    MyFavouriteViewController *myFavourite = [[MyFavouriteViewController alloc] init];
    myFavourite.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myFavourite animated:YES];
}

#pragma mark 跳转到历史业务界面
- (void)pushToMyHistory {
    
}

#pragma mark 跳转到邮寄地址界面
- (void)pushToMyAddress {
    
}

#pragma mark 跳转到进度界面
- (void)pushToProgress {
    YWProgressViewController *progressVC = [[YWProgressViewController alloc] init];
    progressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:progressVC animated:YES];
}

- (void)pushToHelpOrder {
    [AlertShowAssistant alertTip:@"提示" message:@"该功能尚未开通，请留意后续版本" actionTitle:@"确定" defaultHandle:^{
        
    } cancelHandle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self.headView.userName setTitle:username forState:UIControlStateNormal];
    } else {
        [self.headView.userName setTitle:@"登录/注册" forState:UIControlStateNormal];
    }
    
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
