//
//  MyFavouriteTableViewCell.m
//  Carmgr
//
//  Created by admin on 2016/12/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MyFavouriteTableViewCell.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation MyFavouriteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
        [self actionView];
    }
    return self;
}

- (void)configViews {
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(68);
        make.width.mas_equalTo(self.headImageView.mas_height).multipliedBy(1.382);
    }];
    
    self.serviceName = [[UILabel alloc] init];
    [self.contentView addSubview:self.serviceName];
    [self.serviceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
    }];
    
    self.merchantName = [[UILabel alloc] init];
    self.merchantName.textColor = [DefineValue fieldColor];
    [self.contentView addSubview:self.merchantName];
    [self.merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageView);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
    }];
    
    self.price = [[UILabel alloc] init];
    self.price.textColor = [DefineValue mainColor];
    [self.contentView addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
    }];
}

- (void)actionView {
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [DefineValue separaColor];
    NSMutableArray *buttons = [NSMutableArray new];
    NSArray *titles = @[@"取消收藏", @"预约", @"分享"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
        button.tag = 10 + i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:button];
        [buttons addObject:button];
    }
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(background);
    }];
    
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)clickAction:(UIButton *)sender {
    self.collectionClick(sender.tag - 10);
}

- (void)collectionAction:(CollectionClick)click {
    self.collectionClick = click;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
