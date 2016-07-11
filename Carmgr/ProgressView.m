//
//  ProgressView.m
//  Carmgr
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ProgressView.h"
#import <Masonry.h>
#import "ProgressTableViewCell.h"

@interface ProgressView()

@end

@implementation ProgressView
{
    CGFloat width;
    CGFloat height;
    
    UIButton *allBtn;
    
    BOOL isFirst;
}

//- (void)createViewAtSuperView:(UIView *)superView {
//    [superView addSubview:[self createHeadViewAtSuperView]];
//}

- (UITableView *)createTableView:(UIView *)superView {
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
    
    tableView.tableHeaderView = [self createHeadViewAtSuperView];
    
    [tableView registerClass:[ProgressTableViewCell class] forCellReuseIdentifier:[ProgressTableViewCell getReuseID]];
    
    
    //点击隐藏键盘(tableview满屏的情况下)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar:)];
    tap.cancelsTouchesInView = NO;  //重要
    [superView addGestureRecognizer:tap];
    
    return tableView;
}
- (void)hideSearchBar:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - headview
- (UIView *)createHeadViewAtSuperView {
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = width*(1-0.618);
    
    //背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height-1)];
    
    allBtn = [self CustomButton:CGRectMake(0, 0, height/1.5, height-1) title:@"全部" imageName:@"全部橙" selectedImage:@"全部橙"];
    allBtn.tag = 1000;
    allBtn.selected = YES;
    [backView addSubview:allBtn];
    
//    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(height/1.5);
//        make.height.mas_equalTo(height-1);
//        
//    }];
    
    NSArray *firstTitles = @[@"待付款",@"待使用",@"进行中"];
    NSArray *firstImages = @[@"待付款",@"待使用",@"进行中"];
    NSArray *firstSelected = @[@"待付款橙",@"待使用橙",@"进行中橙"];
    NSArray *secondTitles = @[@"已完成",@"待评价",@"退款/售后"];
    NSArray *secondImages = @[@"已完成",@"待评价",@"退款/售后"];
    NSArray *secondSelected = @[@"已完成橙",@"待评价橙",@"退款/售后橙"];
    
    //第一排
    isFirst = YES;
    UIView *firstView = [self createButtonsView:CGRectZero titles:firstTitles images:firstImages selectedImage:firstSelected];
    
    [backView addSubview:firstView];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(width-height/1.5-1);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(height/2-1);
    }];
    
    //第二排
    isFirst = NO;
    UIView *secondView = [self createButtonsView:CGRectZero titles:secondTitles images:secondImages selectedImage:secondSelected];
    
    [backView addSubview:secondView];
    
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).with.offset(1);
        make.width.mas_equalTo(width-height/1.5-1);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(height/2);
    }];
    
    return backView;
    
}

#pragma mark 3buttons
- (UIView *)createButtonsView:(CGRect)frame titles:(NSArray *)titles images:(NSArray *)images selectedImage:(NSArray *)selectedImages {
    CGFloat btnWidth = (width - height / 1.5 - 2) / 3;
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = frame;
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [self CustomButton:CGRectMake(i * btnWidth, 0, btnWidth, height/2-1) title:titles[i] imageName:images[i] selectedImage:selectedImages[i]];
        if (isFirst) {
            button.tag = 1001+i;
        } else {
            button.tag = 1004+i;
        }
        
        [backView addSubview:button];
    }
    
    return backView;
}

#pragma mark button
- (UIButton *)CustomButton:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = frame;
    
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateSelected];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    [button addTarget:self.actionTarget action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置偏移量
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    //title初始x值为imageView的宽度
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.bounds.size.height*0.5+5, (button.bounds.size.width-2*button.imageView.bounds.size.width-button.titleLabel.bounds.size.width)*0.5, 0, 0)];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake((button.bounds.size.height*0.5-button.imageView.bounds.size.height), (button.bounds.size.width-button.imageView.bounds.size.width)*0.5, 0, 0)];
    
    return button;

}

- (void)buttonClick:(UIButton *)sender {
    
}


#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height/6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 9.9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProgressTableViewCell getReuseID] forIndexPath:indexPath];
    cell.storeName.text = [NSString stringWithFormat:@"易务车商店%ld",indexPath.section+1];
    cell.serviceLabel.text = [NSString stringWithFormat:@"易务车服务%ld",indexPath.section+1];
    cell.numberLabel.text = [NSString stringWithFormat:@"订单号：%ld",indexPath.section*10000];
    cell.timeLabel.text = [NSString stringWithFormat:@"2016.7.%ld",indexPath.section+7];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
