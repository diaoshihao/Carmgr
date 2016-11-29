//
//  MessageTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "DefineValue.h"
#import <Masonry.h>

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customCellView];
    }
    return self;
}

- (void)customCellView {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [DefineValue font14];
    [self.titleLabel addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(self.titleLabel.mas_bottom);
    }];
    
    UIView *separator1 = [self separator];
    [separator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
    }];
    
    self.photoView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(separator1.mas_bottom).offset(10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(self.photoView.mas_width).multipliedBy(0.4);
    }];
    
    self.subTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.photoView.mas_left);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIView *separator2 = [self separator];
    [separator2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subTitleLabel.mas_bottom);
    }];
    
    UIButton *button = [self detailButton];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(separator2.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
}

- (UIView *)separator {
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [DefineValue separaColor];
    [self.contentView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue pixHeight] * 2);
    }];
    return separator;
}

- (UIButton *)detailButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击查看详情" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"前进橙"]];
    [button addSubview:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(button.mas_right).offset(-20);
        make.centerY.mas_equalTo(button);
    }];
    return button;
}

- (void)clickAction {
    self.click();
}

#pragma mark - setData
- (void)setModel:(MessageModel *)model {
    _model = model;
    [self loadDataWithModel:model];
}

- (void)loadDataWithModel:(MessageModel *)model {
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.photoView.image = [UIImage imageNamed:model.imageUrl];
    self.subTitleLabel.text = model.subTitle;
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
