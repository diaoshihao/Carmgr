//
//  MerchantTableViewCell.m
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MerchantTableViewCell.h"
#import <Masonry.h>

@implementation MerchantTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //头像
        self.merchantImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.merchantImageView];
        
        //商店名
        self.merchantName = [[UILabel alloc] init];
        self.merchantName.font = [UIFont systemFontOfSize:14];
        self.merchantName.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        [self.contentView addSubview:self.merchantName];
        
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
    [self.merchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.merchantImageView.mas_height).multipliedBy(1.382);
    }];
    
    [self.merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.merchantImageView.mas_right).with.offset(10);
    }];
    
    [self.introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.merchantName.mas_left);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.merchantName.mas_bottom).with.offset(8);
    }];
    
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.merchantName.mas_left);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.road mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.area.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.area);
    }];
    
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
                make.left.mas_equalTo(self.merchantName.mas_left).with.offset(0);
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
    return @"merchanttableviewcell";
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
