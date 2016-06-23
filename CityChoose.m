//
//  CityChoose.m
//  Carmgr
//
//  Created by admin on 16/6/22.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CityChoose.h"
#import "YWPublic.h"

#define maxWidth self.frame.size.width
#define maxHeight self.frame.size.height

@interface CityChoose() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *tableFirst;
@property (nonatomic,strong) UITableView    *tableSecond;
@property (nonatomic,strong) UITableView    *tableThird;

@property (nonatomic,strong) NSMutableArray *dataSourceFirst;
@property (nonatomic,strong) NSMutableArray *dataSourceSecond;
@property (nonatomic,strong) NSMutableArray *dataSourceThird;

@property (nonatomic,assign) BOOL           firstTableViewShow;
@property (nonatomic,assign) BOOL           secondTableViewShow;
@property (nonatomic,assign) BOOL           thirdTableViewShow;

@end

@implementation CityChoose

- (UIButton *)createButtonForChooseCity:(CGRect)frame title:(NSString *)title {
    UIButton *button = [YWPublic createButtonWithFrame:frame title:title imageName:nil];
    [button addTarget:self action:@selector(showFirstTableView) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)showFirstTableView {
    
}
//
//- (void)createTableViewFirst{
//
//    
//    self.tableFirst = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,maxWidth / 3, maxHeight * 2 / 3) style:UITableViewStylePlain];
//    self.tableFirst.scrollEnabled = NO;
//    self.tableFirst.delegate = self;
//    self.tableFirst.dataSource = self;
//    
//    [self insertSubview:self.tableFirst belowSubview:self.backView];
//    
//}
//- (void)createTableViewSecond{
//    self.tableSecond = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.frame.size.width
//                                                                    /2, 0) style:UITableViewStylePlain];
//    self.tableSecond.scrollEnabled = NO;
//    self.tableSecond.delegate = self;
//    self.tableSecond.dataSource = self;
//    self.tableSecond.autoresizesSubviews = NO;
//    [self insertSubview:self.tableSecond belowSubview:self.backView];
//}
//
//- (void)createTableViewThird{
//    self.tableThird = [[UITableView alloc]initWithFrame:CGRectMake(self.tableViewWith*2, CGRectGetMaxY(self.backView.frame), self.frame.size.width
//                                                                   /3, 0) style:UITableViewStylePlain];
//    self.tableThird.scrollEnabled = NO;
//    self.tableThird.delegate = self;
//    self.tableThird.dataSource = self;
//    self.tableThird.autoresizesSubviews = NO;
//    [self insertSubview:self.tableThird belowSubview:self.backView];
//}

@end
