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
#import "YWPublic.h"

@interface AddCarInfoViewController () <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *viewsArr;

@property (nonatomic, strong) AddCarInfoView *infoView;

@property (nonatomic, strong) UISegmentedControl *numberType;//号码类型
@property (nonatomic, strong) UILabel *carType;//车型

@property (nonatomic, strong) UILabel *cityLabel;//城市

@property (nonatomic, strong) UITextField *vehicle_number;//车牌
@property (nonatomic, strong) UITextField *engine_number;//发动机号
@property (nonatomic, strong) UITextField *frame_number;//车架号

@property (nonatomic, strong) UITextField *buy_insu_time;//保险日期
@property (nonatomic, strong) UITextField *first_insu_time;//首次保养
@property (nonatomic, strong) UITextField *travel_mileage;//行驶公里

@property (nonatomic, strong) UITextField *comments;//备注

@end

@implementation AddCarInfoViewController

- (void)loadData {
    
    self.titleArr = @[
                      @[@"号码类型",@"车        型"],
                      @[@"查询城市"],
                      @[@"车牌号码",@"发动机号",@"车架号码"],
                      @[@"保险进保日期",@"首次保养日期",@"行驶公里数"],
                      @[@"备        注"]
                      ];
    
    self.numberType = [self.infoView numberType];
    self.carType = [self.infoView labelWithTitle:@"请选择车辆(选填)"];
    
    self.cityLabel = [self.infoView labelWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"city"]];
    
    NSArray *arr2 = [self.infoView textFieldArray:2];//数字标示是
    NSArray *arr3 = [self.infoView textFieldArray:3];//否添加“粤”
    
    self.vehicle_number = arr2[0];
    self.engine_number = arr2[1];
    self.frame_number = arr2[2];
    
    self.buy_insu_time = arr3[0];
    self.first_insu_time = arr3[1];
    self.travel_mileage = arr3[2];
    
    self.comments = [self.infoView textFieldWithPlaceholder:@"请输入爱车(选填)"];
    
    self.viewsArr = @[
                      @[self.numberType,self.carType],
                      @[self.cityLabel],
                      arr2,
                      arr3,
                      @[self.comments]
                      ];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self customLeftItem];
    
    self.infoView = [[AddCarInfoView alloc] init];
    self.infoView.target = self;
    self.infoView.superView = self.view;
    
    [self loadData];
    //view
    [self createTableView];
    
    //听键盘的即将显示事件. UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘即将消失的事件. UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

//导航栏
- (void)customLeftItem {
    self.navigationItem.title = @"添加车辆";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentMode = UIViewContentModeLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backToLastPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backToLastPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[AddCarInfoCell class] forCellReuseIdentifier:[AddCarInfoCell getReuseID]];
    
    //button
    UIButton *button = [self.infoView createLabelAndButton:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(button.mas_top).with.offset(-20);
    }];
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [self.view addGestureRecognizer:tap];
    
}
- (void)hideSearchBar:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

//添加车辆
- (void)checkCarInfo {
    [self.view endEditing:YES];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSLog(@"%ld,%@,%@,%@,%@",self.numberType.selectedSegmentIndex,self.cityLabel.text,self.vehicle_number.text,self.engine_number.text,self.frame_number.text);
    
    [YWPublic afPOST:[NSString stringWithFormat:kADDCAR,
                      userName,
                      self.numberType.selectedSegmentIndex,
                      [self.cityLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                      self.vehicle_number.text,
                      self.engine_number.text,
                      self.frame_number.text,
                      token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"个人信息%@",dataDict);
        NSLog(@"%@",dataDict[@"opt_info"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"个人信息%@",error);
    }];

}

#pragma mark - tableview delegate
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
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLabel.text = self.titleArr[indexPath.section][indexPath.row];
    cell.cusView = self.viewsArr[indexPath.section][indexPath.row];
    [cell customView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 右滑返回上一页
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    //滑动返回
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    //滑动返回
    [super viewDidDisappear:YES];
    self.navigationController.delegate = nil;
}


#pragma mark - keyboard events -

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    UIView *panelInputTextView = self.tableView;
    CGFloat offset = (64 + panelInputTextView.frame.size.height) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
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
