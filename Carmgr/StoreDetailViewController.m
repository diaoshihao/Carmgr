//
//  StoreDetailViewController.m
//  Carmgr
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "YWPublic.h"
#import "DetailServiceModel.h"

@interface StoreDetailViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIScrollView      *scrollView;
@property (nonatomic, strong) DetailView        *detailView;
@property (nonatomic, strong) UIView            *contentView;

@property (nonatomic, strong) SDCycleScrollView *cycleImage;
@property (nonatomic, strong) UIButton          *addressBtn;
@property (nonatomic, strong) UILabel           *textLabel;
@property (nonatomic, strong) UIButton          *moreButton;

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UITableView       *rateTableView;

@end

@implementation StoreDetailViewController

- (void)loadData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *merchant_name = self.storeModel.merchant_name;
    NSString *urlStr = [[NSString stringWithFormat:kMERCHANT,username,merchant_name,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //网络数据请求
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            self.detailModel = [[DetailModel alloc] initWithDict:dataDict];
            self.cycleImage.imageURLStringsGroup = @[self.detailModel.img_path];
            
            for (NSDictionary *dict in self.detailModel.services_list) {
                DetailServiceModel *model = [[DetailServiceModel alloc] initWithDict:dict];
                [self.detailView.services_list addObject:model];
            }
            
            for (NSDictionary *dict in self.detailModel.rate_list) {
                RateModel *model = [[RateModel alloc] initWithDict:dict];
                [self.detailView.rate_list addObject:model];
            }
            [self dataDidLoad];
        } else {
            [self dataLoadFaile];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dataLoadFaile];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailView = [[DetailView alloc] init];
    
    [self createScrollView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.scrollView addSubview:self.contentView];
    
    self.detailView.contentView = self.contentView;
    
    [self autoLayout];
    
}

- (void)autoLayout {
    //轮播图
    self.cycleImage = [self cycleImage];
    
    //头部视图
    UIView *headView = [self.detailView headViewWithTitle:self.storeModel.merchant_name stars:self.storeModel.stars];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleImage.mas_bottom).with.offset(10);
    }];
    
    //地址
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",self.storeModel.province,self.storeModel.city,self.storeModel.area,self.storeModel.road];
    self.addressBtn = [self.detailView addressButton:address];
    
    //商家详情title
    UILabel *titleLabel = [self titleLabel:@"商家详情"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressBtn.mas_bottom).with.offset(10);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    //商家详情
    self.textLabel = [self.detailView multiLineLabel:self.storeModel.merchant_introduce];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(1);
        make.left.and.right.mas_equalTo(self.contentView);
    }];
    
    //查看更多
    self.moreButton = [self lookMoreButton:100];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textLabel.mas_bottom).with.offset(1);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(self.moreButton.mas_bottom);
    }];
    
}

- (void)dataDidLoad {
    //可办业务
    UILabel *titleLabel = [self titleLabel:@"可办业务"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreButton.mas_bottom).with.offset(10);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    self.tableView = [self.detailView createTableView];
    self.tableView.tableHeaderView = [self titleLabel:@"可办业务"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(1);
        make.left.and.right.mas_equalTo(self.contentView);
        if (self.detailModel.services_list.count > 3) {
            make.height.mas_equalTo(3 * 105 - 1);
        } else {
            make.height.mas_equalTo(self.detailModel.services_list.count * 105 - 1);
        }
    }];
    
    //查看更多
    UIButton *moreService = [self lookMoreButton:200];
    [moreService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).with.offset(1);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    //评论
    self.rateTableView = [self.detailView createRateTableView];
    [self.rateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moreService.mas_bottom).with.offset(10);
        make.left.and.right.mas_equalTo(self.contentView);
        if (self.detailModel.rate_list.count > 3) {
            make.height.mas_equalTo(3 * 105 - 1);
        } else {
            make.height.mas_equalTo(self.detailModel.rate_list.count * 105 - 1);
        }
    }];
    
    UIButton *moreRate = [self lookMoreButton:300];
    [moreRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rateTableView.mas_bottom).with.offset(1);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];

    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(moreRate.mas_bottom);
    }];
    
}

- (void)dataLoadFaile {
    //contact merchant
    
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(self.moreButton.mas_bottom);
    }];
}

- (void)lookForMore:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.tag == 100) {
        if (sender.selected) {
            self.textLabel.numberOfLines = 0;
        } else {
            self.textLabel.numberOfLines = 3;
        }
    } else if (sender.tag == 200) {
        if (self.detailModel.services_list.count <= 3) {
            return;
        }
        if (sender.selected) {
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.detailModel.services_list.count * 105 - 1);
            }];
        } else {
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(3 * 105 - 1);
            }];
        }
    } else if (sender.tag == 300) {
        if (self.detailModel.rate_list.count <= 3) {
            return;
        }
        
        if (sender.selected) {
            [self.rateTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.detailModel.rate_list.count * 105 - 1);
            }];
        } else {
            [self.rateTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(3 * 105 - 1);
            }];
        }
    }
}

- (SDCycleScrollView *)cycleImage {
    SDCycleScrollView *cycleImage = [self.detailView createCycleScrollView:self imageGroup:nil];
    cycleImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cycleImage];
    return cycleImage;
}

- (UILabel *)titleLabel:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = title;
    label.textColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    return label;
}

- (UIButton *)lookMoreButton:(NSInteger)tag {
    UIButton *moreButton = [self.detailView moreButton];
    moreButton.tag = tag;
    [moreButton addTarget:self action:@selector(lookForMore:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreButton];
    return moreButton;
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
