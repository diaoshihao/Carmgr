//
//  AddressPickerController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AddressPickerController.h"
#import "SearchResultTableViewController.h"
#import "SelectAreaTableViewController.h"
#import "HotCityTableViewCell.h"
#import "CurrentCityTableViewCell.h"
#import "ChineseToPinyin.h"

@interface AddressPickerController () <UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>
{
    AddressManager *_manager;
}

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) SelectAreaTableViewController *selectAreaVC;
@property (nonatomic, strong) UITableView *areaTableView;

@property (nonatomic, strong) NSDictionary *cityDict;//按字母排序城市

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSArray *hotCitys;

@property (nonatomic, strong) NSMutableArray *citys;

@property (nonatomic, strong) NSString *currentCity;

@end

@implementation AddressPickerController

- (NSDictionary *)cityDict {
    if (_cityDict == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
        _cityDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return _cityDict;
}

- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        NSArray *arr = @[@"定位城市",@"热门城市"];
        NSArray *allkeys = [self.cityDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        _titleArray = [NSMutableArray arrayWithArray:arr];
        [_titleArray addObjectsFromArray:allkeys];
    }
    return _titleArray;
}

- (NSArray *)hotCitys {
    if (_hotCitys == nil) {
        _hotCitys = @[@"北京",@"上海",@"广州",@"深圳",@"天津",@"南京",@"武汉",@"成都",@"重庆",@"西安",@"杭州"];
    }
    return _hotCitys;
}

- (NSMutableArray *)citys {
    if (_citys == nil) {
        _citys = [[NSMutableArray alloc] init];
        for (NSString *key in self.cityDict.allKeys) {
            NSArray *cityArr = self.cityDict[key];
            for (NSString *city in cityArr) {
                [_citys addObject:city];
            }
        }
    }
    return _citys;
}

- (SelectAreaTableViewController *)selectAreaVC {
    if (_selectAreaVC == nil) {
        _selectAreaVC = [[SelectAreaTableViewController alloc] init];
        _selectAreaVC.sureButton = self.rightItemButton;
    }
    return _selectAreaVC;
}

- (UITableView *)areaTableView {
    if (_areaTableView == nil) {
        _areaTableView = self.selectAreaVC.tableView;
    }
    return _areaTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择城市";
    _manager = [AddressManager manager];
    [self initSearchBar];
    [self initTableView];
    [self configRightItemView];
}

- (void)configRightItemView {
    self.rightItemButton = [CustomButton buttonWithTitle:@"确定"];
    [self.rightItemButton setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    self.rightItemButton.titleLabel.font = [DefineValue font14];
    self.rightItemButton.hidden = YES;
    [self.rightItemButton addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.customNavBar);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenHeight] - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionIndexColor = [DefineValue mainColor];
    self.searchController.searchBar.frame = CGRectMake(0, 64, [DefineValue screenWidth] - 20, 60);
    [self.view addSubview:self.searchController.searchBar];
    tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:tableView];
}

- (void)initSearchBar {
    SearchResultTableViewController *searchResultVC = [[SearchResultTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultVC];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.placeholder = @"输入城市名或拼音";
    self.searchController.searchResultsUpdater = self;
}

- (void)chooseAddress {
    NSArray *address = @[self.currentCity,self.selectAreaVC.selectedArea,self.currentProvince];
    if (self.block) {
        self.block(address);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectedAddress:(returnAddress)address {
    self.block = address;
}

//获取地区列表
- (NSArray *)getAreaListFromCity:(NSString *)city {
    NSMutableArray *areaList = [[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
    NSArray *provinces = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *provinceDict in provinces) {
        for (NSDictionary *cityDict in provinceDict[@"citylist"]) {
            if ([cityDict[@"cityName"] isEqualToString:city]) {
                
                for (NSDictionary *areaDict in cityDict[@"arealist"]) {
                    [areaList addObject:areaDict[@"areaName"]];
                }
                return areaList;
            }
        }
        
    }
    return areaList;
}

//展示地区列表
- (void)showAreaTableView:(NSString *)city {
    self.currentCity = city;
    self.selectAreaVC.dataArray = [self getAreaListFromCity:city];
    self.selectAreaVC.tableView.frame = CGRectMake([DefineValue screenWidth] * 2 / 5, 64, [DefineValue screenWidth] * 3 / 5, [DefineValue screenHeight] - 64);
    [self.view addSubview:self.selectAreaVC.tableView];
    [self.selectAreaVC.tableView reloadData];
}

//获取搜索结果
- (NSArray *)getResultArray:(NSString *)searchText {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSString *city in self.citys) {
        if ([[ChineseToPinyin pinyinFromChineseString:city withSpace:NO] hasPrefix:[searchText lowercaseString]] || [city hasPrefix:searchText]) {
            [resultArray addObject:city];
        }
    }
    return resultArray;
}

//更新搜索结果
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    SearchResultTableViewController *resultVC = (SearchResultTableViewController *)searchController.searchResultsController;
    resultVC.resultArray = [self getResultArray:searchController.searchBar.text];
    resultVC.showBlock = ^(UIView *view, NSString *city) {
        self.selectAreaVC.dataArray = [self getAreaListFromCity:city];
        self.selectAreaVC.tableView.frame = CGRectMake([DefineValue screenWidth] * 2 / 5, 64, [DefineValue screenWidth] * 3 / 5, [DefineValue screenHeight] - 64);
        [view addSubview:self.selectAreaVC.tableView];
        [self.selectAreaVC.tableView reloadData];
    };
    [resultVC.tableView reloadData];
}

#pragma mark - delegate
- (UIView *)headViewForSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], 30)];
    backView.backgroundColor = [DefineValue separaColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [DefineValue screenWidth], 30)];
    label.text = self.titleArray[section];
    label.font = [DefineValue font14];
    [backView addSubview:label];
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self headViewForSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleArray[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.titleArray];
    [arrM replaceObjectAtIndex:0 withObject:@"定位"];
    [arrM replaceObjectAtIndex:1 withObject:@"热门"];
    return arrM;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 1;
    } else {
        NSArray *citys = [self.cityDict objectForKey:self.titleArray[section]];
        return citys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //当前城市cell
    if (indexPath.section == 0) {
        CurrentCityTableViewCell *cell = [[CurrentCityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"currentcitycell"];
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"currentcitycell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clickBlock = ^(UIButton *button) {
            //当前省份
            [self saveCurrentProvince:button.currentTitle];
            
            if (self.hideArea) {
                [self onlySelectCurrentCity:button.currentTitle];
            } else {
                [self showAreaTableView:button.currentTitle];
            }
        };
        cell.hideBlcok = ^(void) {
            self.rightItemButton.hidden = YES;
            [self.areaTableView removeFromSuperview];
        };
        return cell;
        
        //热门城市cell
    } else if (indexPath.section == 1) {
        HotCityTableViewCell *cell = [[HotCityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotcitycell" hotCitys:self.hotCitys];
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"hotcitycell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clickBlock = ^(UIButton *button) {
            //当前省份
            [self saveCurrentProvince:button.currentTitle];
            
            NSArray *arr = @[@"北京",@"上海",@"天津",@"重庆"];
            if (![arr containsObject:button.currentTitle]) {
                NSString *cityStr = [NSString stringWithFormat:@"%@市",button.currentTitle];
                
                if (self.hideArea) {
                    [self onlySelectCurrentCity:cityStr];
                } else {
                    [self showAreaTableView:cityStr];
                }
            } else {
                if (self.hideArea) {
                    [self onlySelectCurrentCity:button.currentTitle];
                } else {
                    [self showAreaTableView:button.currentTitle];
                }
            }
        };
        cell.hideBlcok = ^(void) {
            self.rightItemButton.hidden = YES;
            [self.areaTableView removeFromSuperview];
        };
        return cell;
        
        //普通cell
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        NSArray *citys = [self.cityDict objectForKey:self.titleArray[indexPath.section]];
        cell.textLabel.text = citys[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kButtonHeight + 20;
    } else if (indexPath.section == 1) {
        NSInteger rows = ceilf(self.hotCitys.count / 3.0);
        return rows * kButtonHeight + (rows - 1) * 20 + 44;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    NSArray *citys = [self.cityDict objectForKey:self.titleArray[indexPath.section]];
    NSString *city = citys[indexPath.row];
    
    //当前省份
    [self saveCurrentProvince:city];
    
    //县级市
    if ([[city substringFromIndex:city.length - 1] isEqualToString:@"县"] || self.hideArea) {
        [self onlySelectCurrentCity:city];
    } else {
        self.rightItemButton.hidden = YES;
        [self showAreaTableView:city];
    }
}

- (void)saveCurrentProvince:(NSString *)city {
    self.currentProvince = [_manager provinceFromCity:city];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.currentProvince forKey:@"currentprovince"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//不展示地区列表
- (void)onlySelectCurrentCity:(NSString *)city {
    self.rightItemButton.hidden = NO;
    self.currentCity = city;
    self.selectAreaVC.selectedArea = @"";
    if (self.selectAreaVC.tableView) {
        [self.selectAreaVC.tableView removeFromSuperview];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    self.rightItemButton.hidden = YES;
    [self.areaTableView removeFromSuperview];
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
