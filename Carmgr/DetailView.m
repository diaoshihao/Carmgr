//
//  DetailView.m
//  Carmgr
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DetailView.h"
#import "StoreTableViewCell.h"
#import "RateTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DetailServiceModel.h"

@interface DetailView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DetailView
{
    UILabel *titleLabel;
}

- (NSArray *)services_list {
    if (_services_list == nil) {
        _services_list = [[NSMutableArray alloc] init];
    }
    return _services_list;
}

- (NSMutableArray *)rate_list {
    if (_rate_list == nil) {
        _rate_list = [[NSMutableArray alloc] init];
    }
    return _rate_list;
}

#pragma mark - 轮播图
- (SDCycleScrollView *)createCycleScrollView:(id)delegate imageGroup:(NSArray *)imageNameGroup {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 300 / 720;
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, height) delegate:delegate placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup = imageNameGroup;
    cycleScrollView.autoScrollTimeInterval = 3.5;
    if (imageNameGroup.count == 1) {
        cycleScrollView.autoScroll = NO;
    } else {
        cycleScrollView.autoScroll = YES;
    }
    
    return cycleScrollView;
    
}

- (UIView *)headViewWithTitle:(NSString *)title stars:(NSString *)stars {
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.headView];
    
    [self titleLabel:title];
    
    [self starViewWithStars:stars];
    
    [self payButton];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.button.mas_bottom).with.offset(10);
    }];
    
    return self.headView;
    
}

- (void)titleLabel:(NSString *)title {
    titleLabel = [[UILabel alloc] init];
    [self.headView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
    }];
}

- (void)payButton {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"费用支付" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0]];
    [self.headView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}

- (void)starViewWithStars:(NSString *)stars {
    CGFloat floatVal = [stars floatValue];
    NSInteger intVal = [stars intValue];
    
    UIImageView *lastImage = nil;
    
    //分数取整数，创建整数个星星
    for (NSInteger i = 0; i < intVal; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        starImage.image = [UIImage imageNamed:@"星星"];
        starImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.headView addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(8);
            if (i == 0) {
                make.left.mas_equalTo(20);
            } else {
                make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            }
        }];
        lastImage = starImage;
    }
    
    //如果是x.5分，最后增加半个星星
    if (floatVal > intVal) {
        UIImageView *halfStarImage = [[UIImageView alloc] init];
        halfStarImage.image = [UIImage imageNamed:@"半星"];
        halfStarImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.headView addSubview:halfStarImage];
        
        [halfStarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            make.centerY.mas_equalTo(lastImage);
            make.size.mas_equalTo(lastImage);
        }];
    }
}

- (UIButton *)addressButton:(NSString *)title {
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn setTitle:title forState:UIControlStateNormal];
    [addressBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [addressBtn setBackgroundColor:[UIColor whiteColor]];
    [addressBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [self.headView addSubview:addressBtn];
    
    [addressBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [addressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, addressBtn.imageView.frame.size.width + 5, 0, 0)];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(2);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    return addressBtn;
}

- (UILabel *)multiLineLabel:(NSString *)text {
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.backgroundColor = [UIColor whiteColor];
    textLabel.numberOfLines = 3;
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.firstLineHeadIndent = 20;
    paragraphStyle.headIndent = 20;
    paragraphStyle.tailIndent = -20;
    NSMutableAttributedString *attribueString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    textLabel.attributedText = attribueString;
    [self.contentView addSubview:textLabel];
    return textLabel;
}

- (UIButton *)moreButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    [button setTitle:@"收起更多" forState:UIControlStateSelected];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"下拉黑"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIViewContentModeCenter;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.intrinsicContentSize.width, 0, -button.titleLabel.intrinsicContentSize.width)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.intrinsicContentSize.width, 0, button.imageView.intrinsicContentSize.width)];
    return button;
}

//可办业务
- (UITableView *)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.rowHeight = 105;
    [self.tableView registerClass:[StoreTableViewCell class] forCellReuseIdentifier:[StoreTableViewCell getReuseID]];
    
    [self.contentView addSubview:self.tableView];
    return self.tableView;
}

//评论
- (UITableView *)createRateTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.scrollEnabled = NO;
    
    tableView.rowHeight = 105;
    [tableView registerClass:[RateTableViewCell class] forCellReuseIdentifier:[RateTableViewCell getReuseID]];
    
    [self.contentView addSubview:tableView];
    return tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.services_list.count;
    } else {
        return self.rate_list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[StoreTableViewCell getReuseID] forIndexPath:indexPath];
        
        DetailServiceModel *model = self.services_list[indexPath.row];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.service_img]];
        
        cell.storeName.text = model.service_name;
        cell.introduce.text = model.service_introduce;
        cell.stars = model.service_stars;
        cell.area.text = model.service_address;
        cell.road.text = model.service_address;
        cell.distance.text = model.service_distance;
        
        [cell starView];
        return cell;
    } else {
        RateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RateTableViewCell getReuseID] forIndexPath:indexPath];
        
        RateModel *model = self.rate_list[indexPath.row];
        
        cell.headImageView.image = [UIImage imageNamed:@"头像"];
        
        cell.user.text = model.rate_user;
        cell.time.text = model.rate_time;
        cell.text.text = model.rate_text;
        
        [cell starViewWithStars:model.rate_stars];
        return cell;
    }
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
