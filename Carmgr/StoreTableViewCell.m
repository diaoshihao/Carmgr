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
        UIFont *font = [UIFont systemFontOfSize:14];
        //头像
        self.headImageView = [[UIImageView alloc] init];
//        self.headImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.headImageView];
        
        //商店名
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = font;
        self.storeName.numberOfLines = 0;
        [self.contentView addSubview:self.storeName];
        
        //地址
        self.address = [[UILabel alloc] init];
        self.address.font = font;
        self.address.numberOfLines = 0;
        [self.contentView addSubview:self.address];
        
        //分数
        self.score = [[UILabel alloc] init];
        self.score.font = font;
        [self.contentView addSubview:self.score];
        
        [self autoLayout];
        
    }
    return self;
}

- (void)autoLayout {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(self.headImageView.mas_width);
    }];
    
    [self.storeName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.address setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_top).with.offset(5);
        make.left.mas_equalTo(self.headImageView.mas_right).with.offset(10);
    }];
    
    [self.address setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.address setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom).with.offset(-5);
    }];
}

- (void)servieceLabel {
    
    UIImageView *lastImageView = nil;
    for (NSInteger i = 0; i < self.servieceArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = self.servieceArr[i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        [imageView addSubview:label];
        
        if ([label.text isEqualToString:@"综"]) {
            imageView.image = [UIImage imageNamed:@"圆角矩形绿色"];
        } else if ([label.text isEqualToString:@"金"]) {
            imageView.image = [UIImage imageNamed:@"圆角矩形深蓝"];
        } else if ([label.text isEqualToString:@"洗"]) {
            imageView.image = [UIImage imageNamed:@"圆角矩形粉红"];
        } else if ([label.text isEqualToString:@"修"]) {
            imageView.image = [UIImage imageNamed:@"圆角矩形紫色"];
        } else if ([label.text isEqualToString:@"牌"]) {
            imageView.image = [UIImage imageNamed:@"圆角矩形浅蓝"];
        } else;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastImageView == nil) {
                make.left.mas_equalTo(self.storeName.mas_right).with.offset(15);
            } else {
                make.left.mas_equalTo(lastImageView.mas_right).with.offset(5);
            }
            make.height.mas_equalTo(label.intrinsicContentSize.height);
            make.width.mas_equalTo(imageView.mas_height);
            make.centerY.mas_equalTo(self.storeName);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(imageView);
        }];
        
        lastImageView = imageView;
    }
}

//星级数
- (void)starView {
    CGFloat floatVal = [self.score.text floatValue];
    NSInteger intVal = [self.score.text intValue];
    
    UIImageView *lastImage = nil;
    
    UIView *backView = [[UIView alloc] init];
    [self.contentView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
        make.centerY.mas_equalTo(self.headImageView);
        make.size.mas_equalTo(CGSizeMake(5*15+10, 15));
    }];
    
    //分数取整数，创建整数个红心
    for (NSInteger i = 0; i < intVal; i++) {
        UIImageView *starImage = [[UIImageView alloc] init];
        starImage.image = [UIImage imageNamed:@"红心"];
        starImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [backView addSubview:starImage];
        
        [starImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top).with.offset(0);
            if (i == 0) {
                make.left.mas_equalTo(self.storeName.mas_left).with.offset(0);
            } else {
                make.left.mas_equalTo(lastImage.mas_right).with.offset(2);
            }
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        lastImage = starImage;
    }
    
    //如果是x.5分，最后增加一个半心
    if (floatVal > intVal) {
        UIImageView *halfStarImage = [[UIImageView alloc] init];
        halfStarImage.image = [UIImage imageNamed:@"半心"];
        halfStarImage.contentMode = UIViewContentModeCenter;//自适应图片大小
        [self.contentView addSubview:halfStarImage];
        
        [halfStarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastImage.mas_right).with.offset(2);
            make.centerY.mas_equalTo(lastImage);
            make.size.mas_equalTo(lastImage);
        }];
        
//        lastImage = halfStarImage;
    }
    
    [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_right).with.offset(2);
        make.centerY.mas_equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    
    //联系商家按钮
    self.button = [YWPublic createButtonWithFrame:CGRectZero title:@"联系商家" imageName:nil];
    [self.button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.address);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(self.address);
    }];
    
}

- (void)callAction {
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.mobile]]];
    [self addSubview:callWebview];
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
