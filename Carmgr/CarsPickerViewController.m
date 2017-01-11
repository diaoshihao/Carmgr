//
//  CarsPickerViewController.m
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "CarsPickerViewController.h"
#import "CarsTableViewController.h"

@interface CarsPickerViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CarsPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"汽车品牌";
    
    [self configSubviews];
}

- (void)configSubviews {
    CarsTableViewController *carsTVC = [[CarsTableViewController alloc] init];
    [carsTVC didSelectCar:^(NSString *car) {
        self.pickBlock(car);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self addChildViewController:carsTVC];
    self.tableView = carsTVC.tableView;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
}

- (void)didPickCar:(CarsPickBlock)pickblock {
    self.pickBlock = pickblock;
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
