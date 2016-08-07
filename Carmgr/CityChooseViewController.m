//
//  CityChooseViewController.m
//  yoyo
//
//  Created by YoYo on 16/5/12.
//  Copyright © 2016年 cn.yoyoy.mw. All rights reserved.
//

#import "CityChooseViewController.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface CityChooseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTableView; //主
@property (strong, nonatomic) UITableView *subTableView; //次
@property (strong, nonatomic) NSArray *cityList; //城市列表
@property (assign, nonatomic) NSInteger selIndex;//主列表当前选中的行
@property (assign, nonatomic) NSIndexPath *subSelIndex;//子列表当前选中的行
@property (assign, nonatomic) BOOL clickRefresh;//是否是点击主列表刷新子列表,系统刚开始默认为NO
@property (copy, nonatomic) NSString *province; //选中的省
@property (copy, nonatomic) NSString *area; //选中的地区
@property (copy, nonatomic) NSArray  *areaList;//县
@property (strong, nonatomic) UIButton *sureBtn;//push过来的时候，右上角的确定按钮

@end

@implementation CityChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}

- (void)test {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSArray *address = [NSDictionary dictionaryWithContentsOfFile:plistPath][@"address"];
    for (NSDictionary *province in address) {
        NSLog(@"%@",province[@"state"]);
        for (NSDictionary *city in province[@"citys"]) {
            NSLog(@"%@",city[@"name"]);
            for (NSString *area in city[@"sub"]) {
                NSLog(@"%@",area);
            }
        }
    }
    
}

//赋值
- (void)returnCityInfo:(CityBlock)block {
    _cityInfo = block;
}

#pragma mark 创建两个tableView
- (void)addTableView {
    self.title = @"城市";
    self.view.backgroundColor = [UIColor whiteColor];
    //获取目录下的city.plist文件
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
//    _cityList = [NSArray arrayWithContentsOfFile:plistPath];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    _cityList = [NSDictionary dictionaryWithContentsOfFile:plistPath][@"address"];
    //刚开始，默认选中第一行
    _selIndex = 0;
    _province = _cityList.firstObject[@"state"]; //赋值
    //tableView
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width / 4 + 1, screen_height-49) style:UITableViewStylePlain];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [_mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone]; //默认省份选中第一行
    [self.view addSubview:_mainTableView];
    _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(screen_width / 4, self.navigationController == nil ? 0 : 64, screen_width * 3 / 4, screen_height - 49 - (self.navigationController == nil ? 0 : 64)) style:UITableViewStylePlain];
    _subTableView.dataSource = self;
    _subTableView.delegate = self;
    [self.view addSubview:_subTableView];
    if (self.navigationController != nil) { //push过来这个页面的时候
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.hidden = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_sureBtn];
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
}

- (void)popView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 确认选择
-(void) sureAction {
    if (_cityInfo != nil && _province != nil && _area != nil) {
        _cityInfo(_province, _area, _areaList);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_mainTableView]) {
        return _cityList.count;
    }else {
        NSArray *areaList = _cityList[_selIndex][@"citys"];
        return areaList.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_mainTableView]) {
        static NSString *mainCellId = @"mainCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellId];
        }
        cell.textLabel.text = _cityList[indexPath.row][@"state"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        return cell;
    }else {
        static NSString *subCellId = @"subCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *areaList = _cityList[_selIndex][@"citys"];
        cell.textLabel.text = areaList[indexPath.row][@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        //打钩的颜色
        cell.tintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
        //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
        if (_subSelIndex == indexPath && _clickRefresh == NO) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_mainTableView]) {
        _province = _cityList[indexPath.row][@"state"]; //赋值
        if (self.navigationController != nil) { //不是push过来的
            _sureBtn.hidden = YES;
        }
        _selIndex = indexPath.row;
        _clickRefresh = YES;
        [_subTableView reloadData];
    }else {
        _area = _cityList[_selIndex][@"citys"][indexPath.row][@"name"]; //赋值
        _clickRefresh = NO;
        //之前选中的，取消选择
        UITableViewCell *celled = [tableView cellForRowAtIndexPath:_subSelIndex];
        celled.accessoryType = UITableViewCellAccessoryNone;
        //记录当前选中的位置索引
        _subSelIndex = indexPath;
        //当前选择的打勾
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (self.navigationController == nil) { //不是push过来的
            if (_cityInfo != nil) {
                _cityInfo(_province, _area, _areaList);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else {
            _areaList = _cityList[_selIndex][@"citys"][indexPath.row][@"sub"];
            _sureBtn.hidden = false;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
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
