//
//  CarsTableViewController.m
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CarsTableViewController.h"
#import "DefineValue.h"

@interface CarsTableViewController ()

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CarsTableViewController

- (NSMutableArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = [[NSMutableArray alloc] init];
    }
    return _titleArr;
}

- (NSMutableArray *)imageArr {
    if (_imageArr == nil) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cars"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionIndexColor = [DefineValue mainColor];
}

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars" ofType:@"plist"];
    NSArray *items = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in items) {
        
        //section title  A-Z
        [self.titleArr addObject:dict[@"title"]];
        
        NSMutableArray *names = [[NSMutableArray alloc] init];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (NSDictionary *car in dict[@"cars"]) {
            [names addObject:car[@"name"]];
            [images addObject:car[@"icon"]];
        }
        
        [self.dataArr addObject:names];
        [self.imageArr addObject:images];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleArr[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.titleArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cars" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.section][indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectBlock) {
        self.selectBlock(self.dataArr[indexPath.section][indexPath.row]);
    }
}

- (void)didSelectCar:(SelectCarBlock)selectBlock {
    self.selectBlock = selectBlock;
}

@end
