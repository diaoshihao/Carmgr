//
//  StoreViw.m
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StoreView.h"
#import <Masonry.h>
#import "YWPublic.h"
#import "StoreTableViewCell.h"
#import "StoreModel.h"

@interface StoreView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL          selected;//是否选择排序
@property (nonatomic, strong) UIButton      *lastButton;//选择排序状态下的上一次按钮

@property (nonatomic, strong) UITableView   *sortTableView;

@property (nonatomic, strong) UIView        *superView;
@property (nonatomic, strong) UIView        *lineView;

@property (nonatomic, strong) NSArray       *allSortArr;

@end

@implementation StoreView

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSArray *)allSortArr {
    if (_allSortArr == nil) {
        _allSortArr = @[
                        @[@"全部",@"上牌",@"驾考",@"车险",@"检车",@"维修",@"租车",@"保养",@"二手车",@"车贷",@"新车",@"急救",@"用品",@"停车"],
                        @[@"全城市",@"越秀区",@"天河区",@"番禺区",@"海珠区",@"白云区",@"荔湾区",@"黄浦区",@"增城区",@"花都区",@"南沙区",@"从化市",@"近郊"],
                        @[@"默认排序",@"离我最近",@"评价最高",@"最新发布",@"人气最高",@"价格最低",@"价格最高"]];
    }
    return _allSortArr;
}

#pragma mark - 排序View
- (void)createHeadSortViewAtSuperView:(UIView *)superView {
    self.superView = superView;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 3;
    NSArray *titleArr = @[@"全部",@"全城市",@"默认排序"];
    for (NSInteger i = 0; i < 3; i++) {
        [superView addSubview:[self createButtonAndImage:titleArr[i] image:@"下拉黑" frame:CGRectMake(i * width, 64, width, 44)]];
    }
}

- (UIView *)createButtonAndImage:(NSString *)title image:(NSString *)imageName frame:(CGRect)frame{
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:title imageName:nil];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button sizeToFit];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    if ([button.titleLabel.text isEqualToString:@"全部"]) {
        button.tag = 100;
    } else if ([button.titleLabel.text isEqualToString:@"全城市"]) {
        button.tag = 200;
    } else if ([button.titleLabel.text isEqualToString:@"默认排序"]) {
        button.tag = 300;
    } else {
        
    }
    
    //添加事件
    [button addTarget:self action:@selector(changeSortKey:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    
    CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        if (button.tag != 300) {
            make.size.mas_equalTo(CGSizeMake(size.width*1.5, size.height));
        } else {
            make.size.mas_equalTo(size);
        }
        make.centerY.mas_equalTo(backView);
        make.centerX.mas_equalTo(backView);
    }];
    
    
    //箭头图标
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [YWPublic imageNameWithOriginalRender:@"下拉黑"];
    imageView.highlightedImage = [UIImage imageNamed:@"下拉橙"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.tag = button.tag * 10;
    [backView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button.mas_right).with.offset(5);
        make.centerY.mas_equalTo(button);
    }];
    
    return backView;
}

- (void)changeSortKey:(UIButton *)sender {
    
    //还原按钮颜色
    for (NSInteger i = 1; i <= 3; i++) {
        UIButton *button = [self.superView viewWithTag:i * 100];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *imageView = [self.superView viewWithTag:button.tag * 10];
        imageView.highlighted = NO;
    }
    
    UIImageView *imageView = [self.superView viewWithTag:sender.tag * 10];
    
    //如果是正常页面,点击之后被选中状态,上一次按钮为nil，改变排序名self.sortkey
    if (self.sortkey == SortByNone) {
        self.selected = YES;
        self.lastButton = nil;
        self.sortkey = sender.tag / 100;
        
        [sender setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        imageView.highlighted = YES;
        
        self.sortArr = self.allSortArr[sender.tag/100 - 1];
        [self createSortTableView:self.superView];
        
    } else if (sender == self.lastButton) {
        //如果点击相同的按钮，取消选中状态，排序为None,上一次按钮为nil,移除排序视图
        self.selected = NO;
        self.lastButton = nil;
        self.sortkey = SortByNone;
        
        //移除排序视图
        [self.lineView removeFromSuperview];
        [self.sortTableView removeFromSuperview];
        
    } else { //点击切换不同按钮
        self.selected = YES;
        self.sortkey = sender.tag / 100;
        
        [sender setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        imageView.highlighted = YES;
        
        //切换按钮刷新选择数据
        self.sortArr = self.allSortArr[sender.tag/100 - 1];
        [self.sortTableView reloadData];
    }
    
    //上一次的按钮
    self.lastButton = sender;
    
}



#pragma mark - Tableview
- (void)createTableView:(UIView *)superView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:244/256.0 alpha:1];
    [superView addSubview:view];
    
    self.sortkey = SortByNone;
    self.selected = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.height/7;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[StoreTableViewCell class] forCellReuseIdentifier:[StoreTableViewCell getReuseID]];
    
    [superView addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [superView addGestureRecognizer:tap];
    
}

- (void)createSortTableView:(UIView *)superView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:244/256.0 alpha:1];
    self.lineView = view;
    [superView addSubview:view];
    
    self.sortTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.sortTableView.delegate = self;
    self.sortTableView.dataSource = self;
    
    self.sortTableView.tableFooterView = [[UIView alloc] init];
    [self.sortTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sortcell"];
    
    [superView addSubview:self.sortTableView];
    self.sortTableView.showsVerticalScrollIndicator = NO;
    
    [self.sortTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44);
    }];
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [superView addGestureRecognizer:tap];
    
}
- (void)hideSearchBar:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.dataArr.count;
    } else {
        return self.sortArr.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[StoreTableViewCell getReuseID] forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        StoreModel *model = self.dataArr[indexPath.row];
        
        if (model.img_path == nil) {
            cell.headImageView.image = [UIImage imageNamed:@"u10"];
        } else {
            cell.headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.img_path] options:0 error:nil]];
        }
        
        cell.storeName.text = model.merchant_name;
        cell.servieceArr = [model.tags componentsSeparatedByString:@"|"];
        cell.score.text = [NSString stringWithFormat:@"%.1lf分",[model.stars floatValue]];
        cell.address.text = model.address;
        cell.mobile = model.mobile;
        
        [cell.button addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        
        [cell servieceLabel];
        [cell starView];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sortcell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.sortArr[indexPath.row];
        return cell;
    }
}
- (void)callAction {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //改变选中颜色
    for (NSInteger i = 1; i <= 3; i++) {
        UIButton *button = [self.superView viewWithTag:i * 100];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *imageView = [self.superView viewWithTag:button.tag * 10];
        imageView.highlighted = NO;
        
        if (self.sortkey == i) {
            [button setTitle:self.sortArr[indexPath.row] forState:UIControlStateNormal];
        }
    }
    
    self.sortkey = SortByNone;
    self.selected = NO;
    
    if (tableView == self.tableView) {
        //网络数据请求
        
        //跳转到详情页
    } else {
        
        //移除排序视图
        [self.lineView removeFromSuperview];
        [self.sortTableView removeFromSuperview];
        
        //网络排序数据请求
        
        
        //刷新正常视图数据
        [self.tableView reloadData];
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
