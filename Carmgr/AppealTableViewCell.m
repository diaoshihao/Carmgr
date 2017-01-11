//
//  AppealTableViewCell.m
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "AppealTableViewCell.h"
#import "DefineValue.h"
#import <Masonry.h>

@implementation AppealTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.appealImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.appealImageView];
    [self.appealImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(self.appealImageView.mas_height).multipliedBy(1.382);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    
    NSArray *labels = @[self.titleLabel, self.priceLabel, self.timeLabel];
    [labels mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.appealImageView.mas_right).offset(10);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.appealImageView.mas_bottom);
    }];
    
    UIView *editView = [self editView];
    [self.contentView addSubview:editView];
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.appealImageView.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (UIView *)editView {
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [UIColor whiteColor];
    
    UIView *separatView = [[UIView alloc] init];
    separatView.frame = CGRectMake(0, 0, [DefineValue screenWidth], [DefineValue pixHeight] * 2);
    separatView.backgroundColor = [DefineValue separaColor];
    [background addSubview:separatView];
    
    UIButton *cancel = [self actionButton:@""];
    cancel.tag = 10;
    [background addSubview:cancel];
    
    UIButton *edit = [self actionButton:@""];
    edit.tag = 11;
    [background addSubview:edit];
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(edit.mas_left).offset(-30);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(background);
    }];
    
    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(background);
    }];
    
    return background;
}

- (UIButton *)actionButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 2;
    return button;
}

- (void)buttonClick:(UIButton *)sender {
    AppealAction aciton = sender.tag - 10;
    if (self.appealBlock) {
        self.appealBlock(aciton);
    }
}

- (void)appealActionBegin:(AppealActionBlock)appealBlock {
    self.appealBlock = appealBlock;
}

+ (NSString *)getReuseID {
    return @"appealcell";
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
