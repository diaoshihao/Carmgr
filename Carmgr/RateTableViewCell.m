//
//  RateTableViewCell.m
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "RateTableViewCell.h"
#import <Masonry.h>

@implementation RateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //头像
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headImageView];
        
        //用户名
        self.user = [[UILabel alloc] init];
        self.user.font = [UIFont systemFontOfSize:14];
        self.user.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        [self.contentView addSubview:self.user];
        
        //时间
        self.time = [[UILabel alloc] init];
        self.time.font = [UIFont systemFontOfSize:12];
        self.time.textColor = [UIColor colorWithRed:102/256.0 green:102/256.0 blue:102/256.0 alpha:1];
        [self.contentView addSubview:self.time];
        
        //内容
        self.text = [[UILabel alloc] init];
        self.text.numberOfLines = 5;
        self.text.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.text];
        
        [self autoLayout];
        
    }
    return self;
}

- (void)autoLayout {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(self.time.mas_bottom);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    
    [self.user setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(10);
    }];
    
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).with.offset(20);
        make.left.and.right.mas_equalTo(self.contentView);
    }];
    
}

//星级数
- (void)starViewWithStars:(NSString *)stars {
    CGFloat floatVal = [stars floatValue];
    NSInteger intVal = [stars intValue];
    
    UIImageView *lastImage = nil;
    
    //分数取整数，创建整数个星星
    for (NSInteger i = 0; i < intVal; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        starImage.image = [UIImage imageNamed:@"星星"];
        starImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.contentView addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.time);
            if (i == 0) {
                make.left.mas_equalTo(self.user.mas_left);
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
        [self.contentView addSubview:halfStarImage];
        
        [halfStarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastImage.mas_right).with.offset(6);
            make.centerY.mas_equalTo(lastImage);
            make.size.mas_equalTo(lastImage);
        }];
    }
    
    [self.time setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.user.mas_bottom).with.offset(10);
        make.left.mas_equalTo(lastImage.mas_right).with.offset(10);
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.firstLineHeadIndent = 20;
    paragraphStyle.headIndent = 20;
    paragraphStyle.tailIndent = -20;
    NSMutableAttributedString *attribueString = [[NSMutableAttributedString alloc] initWithString:self.text.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    self.text.attributedText = attribueString;
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.text.mas_bottom);
//    }];
}

+ (NSString *)getReuseID {
    return @"ratetableviewcell";
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