//
//  StoreTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StoreTableViewCell.h"
#import <Masonry.h>
#import "YWPublic.h"

@implementation StoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIFont *font = [UIFont systemFontOfSize:15];
        //头像
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headImageView];
        
        //商店名
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = font;
        [self.contentView addSubview:self.storeName];
        
        //地址
        self.address = [[UILabel alloc] init];
        self.address.font = font;
        [self.contentView addSubview:self.address];
        
        //分数
        self.score = [[UILabel alloc] init];
        self.score.font = font;
        [self.contentView addSubview:self.score];
        
        [self autoLayout];
        [self starView];
    }
    return self;
}

- (void)autoLayout {
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    
    [self.storeName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.address setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_top).with.offset(5);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(10);
//        make.size.mas_equalTo(CGSizeMake((width - 40 - self.headImageView.frame.size.width)/2, 20));
    }];
    
    [self.address setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.address setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom).with.offset(-5);
//        make.size.mas_equalTo(self.storeName);
    }];
}

//星级数
- (void)starView {
//    CGFloat floatVal = [self.score floatValue];
//    NSInteger intVal = [self.score intValue];
    
    __weak typeof(self) weakSelf = self;
    
    UIImageView *lastImage = nil;
    
    UIView *backView = [[UIView alloc] init];
    [self.contentView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.storeName.mas_left).with.offset(0);
        make.centerY.mas_equalTo(weakSelf.headImageView);
        make.size.mas_equalTo(CGSizeMake(5*15+10, 15));
    }];
    
    //星级
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        starImage.image = [UIImage imageNamed:@"红心"];
        starImage.contentMode = UIViewContentModeCenter;
        [backView addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top).with.offset(0);
            if (i == 0) {
                make.left.mas_equalTo(weakSelf.storeName.mas_left).with.offset(0);
            } else {
                make.left.mas_equalTo(lastImage.mas_right).with.offset(2);
            }
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        lastImage = starImage;
    }
//    if (floatVal > intVal) {
//        UIImageView *halfStarImage = [[UIImageView alloc] init];
//        halfStarImage.image = [UIImage imageNamed:@"半心"];
//        [self.contentView addSubview:halfStarImage];
//        
//        [halfStarImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lastImage.mas_right).with.offset(2);
//            make.centerY.mas_equalTo(lastImage);
//            make.size.mas_equalTo(lastImage);
//        }];
//        
//        lastImage = halfStarImage;
//    }
    
    [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_right).with.offset(2);
        make.centerY.mas_equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    
    //联系商家按钮
    UIButton *button = [YWPublic createButtonWithFrame:CGRectZero title:@"联系商家" imageName:nil];
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(weakSelf.address);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(weakSelf.address);
    }];
    
}

+ (NSString *)getReuseID {
    return @"storetableviewcell";
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
