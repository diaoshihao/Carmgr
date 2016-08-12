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
        make.bottom.mas_equalTo(self.button.mas_bottom).with.offset(13);
    }];
    
    return self.headView;
    
}

- (void)titleLabel:(NSString *)title {
    titleLabel = [[UILabel alloc] init];
    [self.headView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithRed:51.0/256.0 green:51.0/256.0 blue:51.0/256.0 alpha:1.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
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
        make.height.mas_equalTo(41);
    }];
}

- (UIView *)separatorView {
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor colorWithRed:240.0/256.0 green:240.0/256.0 blue:240.0/256.0 alpha:1.0];
    return separator;
}

- (UIButton *)contactButton:(NSString *)title image:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor colorWithRed:102.0/256.0 green:102.0/256.0 blue:102.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    CGFloat btnWidth = button.intrinsicContentSize.width;
    CGFloat titleWidth = button.titleLabel.intrinsicContentSize.width;
    CGFloat titleHeight = button.titleLabel.intrinsicContentSize.height;
    CGFloat imageWidth = button.imageView.intrinsicContentSize.width;
    CGFloat imageHeight = button.imageView.intrinsicContentSize.height;
    
    //title初始x值为imageView的宽度
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(-titleHeight, (btnWidth-imageWidth), 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight+12, (btnWidth-2*imageWidth-titleWidth), 9, 0)];
    
    return button;
}

- (UIView *)contactView {
    UIView *contactView = [[UIView alloc] init];
    contactView.backgroundColor = [UIColor colorWithRed:250.0/256.0 green:250.0/256.0 blue:250.0/256.0 alpha:1.0];
    
    
    UIButton *lastBtn = nil;
    NSArray *titles = @[@"微信",@"QQ",@"电话"];
    NSArray *images = @[@"微信联系",@"QQ联系",@"电话联系"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *contactBtn = [self contactButton:titles[i] image:images[i]];
        [contactBtn setTitleColor:[UIColor colorWithRed:102.0/256.0 green:102.0/256.0 blue:102.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        contactBtn.tag = 1000*(i+1);
        [contactBtn addTarget:self action:@selector(contactAction:) forControlEvents:UIControlEventTouchUpInside];
        [contactView addSubview:contactBtn];
        
        [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            if (lastBtn == nil) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(lastBtn.mas_right).with.offset(1);
            }
            make.height.mas_equalTo(contactView.mas_height);
            make.width.mas_equalTo(contactView.mas_height).multipliedBy(1.5);
        }];
        
        lastBtn = contactBtn;
        
        UIView *separator = [self separatorView];
        [contactView addSubview:separator];
        
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastBtn.mas_right);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(lastBtn);
        }];

    }
    
    UIButton *serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    serviceBtn.tag = 4000;
    [serviceBtn setTitleColor:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    [serviceBtn setTitle:@"业务预约" forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [serviceBtn addTarget:self action:@selector(contactAction:) forControlEvents:UIControlEventTouchUpInside];
    [contactView addSubview:serviceBtn];
    
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(lastBtn.mas_right).with.offset(1);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    return contactView;
}

- (void)contactAction:(UIButton *)sender {
    if (sender.tag == 1000) {
        [self wechatContact];
    } else if (sender.tag == 2000) {
        [self QQContact];
    } else if (sender.tag == 3000) {
        [self callAction];
    } else if (sender.tag == 4000) {
        [self service];
    } else {
        
    }
}

- (void)wechatContact {
    NSString *kCode = @"1HWhrmvERIU5h3rNnyDw";
    NSString *urlStr = [NSString stringWithFormat:@"weixin://qr/%@",kCode];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (void)QQContact {
    NSString *QQNumber = @"1945293625";
    NSString *urlStr = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQNumber];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.contentView addSubview:webView];
}

//拨打电话
- (void)callAction {
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:400-111-9665"]]];
    [self.contentView addSubview:callWebview];
}

//业务预约
- (void)service {
    self.target.tabBarController.selectedIndex = 3;
}

- (void)starViewWithStars:(NSString *)stars {
    CGFloat floatVal = [stars floatValue];
    NSInteger intVal = [stars intValue];
    
    UIImageView *lastImage = nil;
    
    //分数取整数，创建整数个星星
    for (NSInteger i = 0; i < intVal; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        starImage.image = [UIImage imageNamed:@"大星星"];
        starImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.headView addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(14);
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
        halfStarImage.image = [UIImage imageNamed:@"大半星"];
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
    [addressBtn setTitleColor:[UIColor colorWithRed:102.0/256.0 green:102.0/256.0 blue:102.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    addressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [addressBtn setBackgroundColor:[UIColor whiteColor]];
    [addressBtn setImage:[UIImage imageNamed:@"定位-1"] forState:UIControlStateNormal];
    [self.headView addSubview:addressBtn];
    
    [addressBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [addressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [addressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, addressBtn.imageView.frame.size.width + 8, 0, 0)];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    return addressBtn;
}

- (UILabel *)multiLineLabel:(NSString *)text {
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.backgroundColor = [UIColor whiteColor];
    textLabel.numberOfLines = 3;
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [UIColor colorWithRed:51.0/256.0 green:51.0/256.0 blue:51.0/256.0 alpha:1.0];
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
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:[UIColor colorWithRed:102.0/256.0 green:102.0/256.0 blue:102.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"下拉黑"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"上拉黑"] forState:UIControlStateSelected];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.intrinsicContentSize.width+3, 0, -button.titleLabel.intrinsicContentSize.width-3)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.intrinsicContentSize.width-3, 0, button.imageView.intrinsicContentSize.width+3)];
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
    
    tableView.estimatedRowHeight = 115;
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
        
        cell.headImageView.image = [UIImage imageNamed:@"评论头像"];
        
        cell.user.text = model.rate_user;
        cell.time.text = [model.rate_time componentsSeparatedByString:@" "].firstObject;
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
