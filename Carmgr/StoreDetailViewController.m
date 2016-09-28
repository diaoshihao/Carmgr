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
#import <UIImageView+WebCache.h>

@interface StoreDetailViewController () <SDCycleScrollViewDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView      *scrollView;
@property (nonatomic, strong) DetailView        *detailView;
@property (nonatomic, strong) UIView            *contentView;

@property (nonatomic, strong) SDCycleScrollView *cycleImage;
@property (nonatomic, strong) UIImageView       *headImageView;
@property (nonatomic, strong) UIButton          *addressBtn;
@property (nonatomic, strong) UILabel           *textLabel;
@property (nonatomic, strong) UIButton          *moreButton;

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UITableView       *rateTableView;

@property (nonatomic, strong) UIView            *contactView;

@property (nonatomic, strong) NSMutableArray    *openArr;
@property (nonatomic, strong) NSMutableArray    *closeArr;//当收起更多时的数据源

@end

@implementation StoreDetailViewController

- (NSMutableArray *)openArr {
    if (_openArr == nil) {
        _openArr = [[NSMutableArray alloc] init];
    }
    return _openArr;
}

- (NSMutableArray *)closeArr {
    if (_closeArr == nil) {
        _closeArr = [[NSMutableArray alloc] init];
    }
    return _closeArr;
}

- (void)loadData {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *merchant_name = self.storeModel.merchant_name;
    NSString *urlStr = [[NSString stringWithFormat:kMERCHANT,username,merchant_name,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //网络数据请求
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"] /*&& [dataDict[@"list_size"] integerValue] != 0*/) {
            self.detailModel = [[DetailModel alloc] initWithDict:dataDict];
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.img_path]];
            
            for (NSDictionary *dict in self.detailModel.services_list) {
                DetailServiceModel *model = [[DetailServiceModel alloc] initWithDict:dict];
                [self.detailView.services_list addObject:model];
            }
            
            for (NSDictionary *dict in self.detailModel.rate_list) {
                RateModel *model = [[RateModel alloc] initWithDict:dict];
                [self.openArr addObject:model];
            }
            if (self.openArr.count > 3) {
                for (NSInteger i = 0; i < 3; i++) {
                    [self.closeArr addObject:self.openArr[i]];
                }
            } else {
                self.closeArr = self.openArr;
            }
            
            [self dataDidLoad];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //实现滑动返回
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailView = [[DetailView alloc] init];
    self.detailView.target = self;
    
    [self createScrollView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
        
    //滑动返回
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

#pragma mark - 右滑返回上一页
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    //滑动返回
    [super viewDidDisappear:YES];
    self.navigationController.delegate = nil;
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
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithRed:240.0/256.0 green:240.0/256.0 blue:240.0/256.0 alpha:1.0];
    [self.scrollView addSubview:self.contentView];
    
    self.detailView.contentView = self.contentView;
    
    //联系
    self.contactView = [self.detailView contactView];
    [self.view addSubview:self.contactView];
    
    [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    [self autoLayout];
    
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)autoLayout {
    //头像
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    self.headImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(self.headImageView.mas_width).multipliedBy(35.0/75);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"后退白"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.headImageView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
    }];
    
    //头部视图
    UIView *headView = [self.detailView headViewWithTitle:self.storeModel.merchant_name stars:self.storeModel.stars];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).with.offset(10);
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
    
    UIView *topView = [self whiteViewForLabel];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(1/[[UIScreen mainScreen] scale]);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(16);
    }];
    
    self.textLabel = [self.detailView multiLineLabel:self.storeModel.merchant_introduce];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).with.offset(0);
        make.left.and.right.mas_equalTo(self.contentView);
    }];
    
    UIView *bottomView = [self whiteViewForLabel];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textLabel.mas_bottom).with.offset(0);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(16);
    }];
    
    //查看更多
    self.moreButton = [self lookMoreButton:100];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_bottom).with.offset(0);
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(1/[[UIScreen mainScreen] scale]);
        make.left.and.right.mas_equalTo(self.contentView);
        if (self.detailModel.services_list.count > 3) {
            make.height.mas_equalTo(3 * 105 - 1);
        } else if (self.detailModel.services_list.count != 0) {
            make.height.mas_equalTo(self.detailModel.services_list.count * 105 - 1);
        }
    }];
    
    //查看更多
    UIButton *moreService = [self lookMoreButton:200];
    [moreService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).with.offset(0);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    
    //评论
    self.detailView.rate_list = self.closeArr;
    if (self.closeArr.count == 0) {
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.scrollView);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.bottom.mas_equalTo(moreService.mas_bottom);
        }];
        return;
    }
    self.rateTableView = [self.detailView createRateTableView];
    
    UIButton *moreRate = [self lookMoreButton:300];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    moreRate.frame = CGRectMake(0, 0, width, 44);
    
    self.rateTableView.tableFooterView = moreRate;
    [self.rateTableView reloadData];
    
    [self.rateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moreService.mas_bottom).with.offset(10);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo([self getRateTableViewHeight]);
    }];
    [self.rateTableView layoutIfNeeded];

    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(self.rateTableView.mas_bottom);
    }];
    
    
}

- (CGFloat)getRateTableViewHeight {
    return self.rateTableView.contentSize.height;
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
        [self.tableView layoutIfNeeded];
    } else if (sender.tag == 300) {
        if (self.openArr.count <= 3) {
            return;
        }
        
        if (sender.selected) {
            self.detailView.rate_list = self.openArr;
            [self.rateTableView reloadData];
            [self.rateTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo([self getRateTableViewHeight]);
            }];
        } else {
            self.detailView.rate_list = self.closeArr;
            [self.rateTableView reloadData];
            [self.rateTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo([self getRateTableViewHeight]);
            }];
        }
        [self.rateTableView layoutIfNeeded];
    }
}

- (SDCycleScrollView *)cycleImage {
    SDCycleScrollView *cycleImage = [self.detailView createCycleScrollView:self imageGroup:nil];
    [self.contentView addSubview:cycleImage];
    return cycleImage;
}

- (UILabel *)titleLabel:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 44, width, 1/[[UIScreen mainScreen] scale])];
    separator.backgroundColor = [UIColor colorWithRed:200.0/256.0 green:199.0/256.0 blue:204.0/256.0 alpha:1.0];
    [label addSubview:separator];
    return label;
}

- (UIButton *)lookMoreButton:(NSInteger)tag {
    UIButton *moreButton = [self.detailView moreButton];
    moreButton.tag = tag;
    [moreButton addTarget:self action:@selector(lookForMore:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreButton];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1/[[UIScreen mainScreen] scale])];
    separator.backgroundColor = [UIColor colorWithRed:200.0/256.0 green:199.0/256.0 blue:204.0/256.0 alpha:1.0];
    [moreButton addSubview:separator];
    return moreButton;
}

- (UIView *)whiteViewForLabel {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    return view;
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
