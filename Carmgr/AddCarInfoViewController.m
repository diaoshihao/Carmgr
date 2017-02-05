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
#import "Interface.h"
#import "UIViewController+ShowView.h"
#import "CarsPickerViewController.h"
#import "AddressPickerController.h"
#import "AddressManager.h"

@interface AddCarInfoViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *viewsArr;

@property (nonatomic, strong) AddCarInfoView *infoView;

@property (nonatomic, strong) UISegmentedControl *numberType;//号码类型
@property (nonatomic, strong) UILabel *vehicle_brand;//品牌

@property (nonatomic, strong) UILabel *cityLabel;//城市
@property (nonatomic, strong) NSString *abbreviation;//省份简称

@property (nonatomic, strong) UITextField *vehicle_number;//车牌
@property (nonatomic, strong) UITextField *engine_number;//发动机号
@property (nonatomic, strong) UITextField *frame_number;//车架号

@end

@implementation AddCarInfoViewController

- (void)loadData {
    
    self.titleArr = @[
                      @[@"号码类型",@"车        型"],
                      @[@"查询城市"],
                      @[@"车牌号码",@"发动机号",@"车架号码"],
                      ];
    
    self.numberType = [self.infoView numberType];
    self.vehicle_brand = [self.infoView labelWithTitle:@"请选择车辆(选填)"];
    
    self.cityLabel = [self.infoView labelWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"city"]];
    
    NSArray *arr2 = [self.infoView textFieldArray:2];
    
    self.vehicle_number = arr2[0];
    self.vehicle_number.delegate = self;
    
    self.engine_number = arr2[1];
    self.engine_number.keyboardType = UIKeyboardTypeNumberPad;
    
    self.frame_number = arr2[2];
    self.frame_number.keyboardType = UIKeyboardTypeNumberPad;
    
    self.viewsArr = @[
                      @[self.numberType,self.vehicle_brand],
                      @[self.cityLabel],
                      arr2,
                      ];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加车辆";
    
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

- (void)createTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerClass:[AddCarInfoCell class] forCellReuseIdentifier:[AddCarInfoCell getReuseID]];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44 * 6 + 31);
    }];
    
    //button
    [self.infoView createLabelAndButton:self.tableView];
}

//检查数据完整性
- (BOOL)isComplete {
    if (self.cityLabel.text.length == 0) {
        [self showAlertOnlyMessage:@"请选择城市"];
        return NO;
    }
    if (self.vehicle_number.text.length == 0) {
        [self showAlertOnlyMessage:@"请输入车牌号码"];
        return NO;
    }
    if (self.engine_number.text.length != 4) {
        [self showAlertOnlyMessage:@"发动机号只能输入4位数"];
        return NO;
    }
    if (self.frame_number.text.length != 6) {
        [self showAlertOnlyMessage:@"车架号码只能输入6位数"];
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *alpha = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSString *number = @"0123456789";
    
    if ([string isEqualToString:@""] || [string isEqualToString:@"\n"]) {
        return YES;
    }
    if (string.length > 1) {
        return NO;
    }
    
    if (textField.text.length == 0) {
        if (![alpha containsString:string]) {
            [self showAlertOnlyMessage:@"第一位只能输入字母"];
            return NO;
        }
    } else {
        if (![alpha containsString:string] && ![number containsString:string]) {
            [self showAlertOnlyMessage:@"只能输入字母或数字"];
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.text = [textField.text uppercaseString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

//添加车辆
- (void)checkCarInfo {
    [self.view endEditing:YES];
    if (![self isComplete]) {
        return;
    }
    
    //车牌号：合成格式 粤A12345
    NSString *vehicle_number = [NSString stringWithFormat:@"%@%@",self.abbreviation,self.vehicle_number.text];
    
    NSArray *addCarInfo = [Interface appaddcarinfo_car_type:[NSString stringWithFormat:@"%ld",self.numberType.selectedSegmentIndex] city:self.cityLabel.text vehicle_brand:self.vehicle_brand.text vehicle_number:vehicle_number engine_number:self.engine_number.text frame_number:self.frame_number.text];
    [MyNetworker POST:addCarInfo[InterfaceUrl] parameters:addCarInfo[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self showAlert:YES];
        } else {
            [self showAlert:NO];
        }
    } failure:^(NSError *error) {
        [self showAlertOnlyMessage:@"网络错误"];
    }];
    
}

- (void)addCarInfoSuccessful:(AddCarSuccessBlock)successBlock {
    self.successBlock = successBlock;
}

- (void)showAlert:(BOOL)isSuccess {
    NSString *message = @"添加车辆成功";
    NSString *title = @"确定";
    if (!isSuccess) {
        message = @"添加车辆失败";
        title = @"重试";
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.successBlock();
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertVC addAction:sure];
    
    if (!isSuccess) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVC addAction:cancel];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
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
    AddCarInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[AddCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AddCarInfoCell getReuseID]];
    }
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
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self showCarsPicker];
    }
    
    if (indexPath.section == 1) {
        [self showAddressPicker];
    }
}

//cars
- (void)showCarsPicker {
    CarsPickerViewController *carsPicker = [[CarsPickerViewController alloc] init];
    [carsPicker didPickCar:^(NSString *car) {
        self.vehicle_brand.text = car;
    }];
    [self.navigationController pushViewController:carsPicker animated:YES];
}

//address
- (void)showAddressPicker {
    AddressPickerController *addressPicker = [[AddressPickerController alloc] init];
    addressPicker.hideArea = YES;
    [addressPicker selectedAddress:^(NSArray *address) {
        self.cityLabel.text = address.firstObject;
        [self addLeftView:address.lastObject];
    }];
    [self.navigationController pushViewController:addressPicker animated:YES];
}

- (void)addLeftView:(NSString *)name {
    if ([name isEqualToString:@""]) {
        return;
    }
    
    AddressManager *manager = [AddressManager manager];
    self.abbreviation = [manager abbreviationFromProvince:name];
    
    UILabel *label = [self.infoView labelWithTitle:self.abbreviation];
    label.textAlignment = NSTextAlignmentCenter;
    CGSize size = label.intrinsicContentSize;
    label.frame = CGRectMake(0, 0, size.width+10, size.height+10);
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.vehicle_number.leftView = label;
    self.vehicle_number.leftViewMode = UITextFieldViewModeAlways;
    
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
