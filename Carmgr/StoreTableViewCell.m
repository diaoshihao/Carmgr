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
        //头像
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headImageView];
        
        //商店名
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = [UIFont systemFontOfSize:14];
        self.storeName.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        [self.contentView addSubview:self.storeName];
        
        //商家介绍
        self.introduce = [[UILabel alloc] init];
        self.introduce.numberOfLines = 1;
        self.introduce.font = [UIFont systemFontOfSize:12];
        self.introduce.textColor = [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
        [self.contentView addSubview:self.introduce];
        
        UIColor *color = [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
        
        //地区
        self.area = [[UILabel alloc] init];
        self.area.font = [UIFont systemFontOfSize:11];
        self.area.textColor = color;
        [self.contentView addSubview:self.area];
        
        //街道
        self.road = [[UILabel alloc] init];
        self.road.font = [UIFont systemFontOfSize:11];
        self.road.textColor = color;
        [self.contentView addSubview:self.road];
        
        //距离
        self.distance = [[UILabel alloc] init];
        self.distance.font = [UIFont systemFontOfSize:11];
        self.distance.textColor = color;
        [self.contentView addSubview:self.distance];
        
        [self autoLayout];
        
    }
    return self;
}

- (void)autoLayout {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(93);
    }];
    
    [self.storeName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.storeName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(10);
    }];
    
    [self.introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.storeName.mas_bottom).with.offset(8);
    }];
    
    [self.area setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeName.mas_left);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.road setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.road mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.area.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.area);
    }];
    
    [self.distance setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.area);
    }];
}

//星级数
- (void)starView {
    CGFloat floatVal = [self.stars floatValue];
    NSInteger intVal = [self.stars intValue];
    
    UIImageView *lastImage = nil;
    
    //分数取整数，创建整数个星星
    for (NSInteger i = 0; i < intVal; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        starImage.image = [UIImage imageNamed:@"星星"];
        starImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.contentView addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.introduce.mas_bottom).with.offset(8);
            if (i == 0) {
                make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
            } else {
                make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            }
//            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        lastImage = starImage;
    }
    
    //如果是x.5分，最后增加半个星星
    if (floatVal > intVal) {
        UIImageView *halfStarImage = [[UIImageView alloc] init];
        halfStarImage.image = [UIImage imageNamed:@"半星"];
        halfStarImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.contentView addSubview:halfStarImage];
        
        [halfStarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            make.centerY.mas_equalTo(lastImage);
            make.size.mas_equalTo(lastImage);
        }];
    }
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
