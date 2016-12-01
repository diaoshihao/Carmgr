//
//  CurrentCityTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CurrentCityTableViewCell.h"
#import "DefineValue.h"

@implementation CurrentCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [DefineValue separaColor];
        self.GPSButton = [self buttonForCell:@"未知城市" frame:CGRectMake(20, 10, kButtonWidth, kButtonHeight)];
        [self.contentView addSubview:self.GPSButton];
        [self.contentView addSubview:self.activityIndicator];
        [self startLocation];
    }
    return self;
}

- (void)buttonDidClick:(UIButton *)sender {
    self.clickBlock(sender);
}

- (UIButton *)buttonForCell:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [DefineValue font14];
    [button setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.enabled = NO;
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)startLocation {
    [self.activityIndicator startAnimating];
    [self.GPSButton setTitle:@"定位中..." forState:UIControlStateNormal];
    self.locationManager = [[LocationManager alloc] init];
    [self.locationManager starLocation];
    [self.locationManager locationCompletion:^(NSString *location) {
        [self.activityIndicator stopAnimating];
        self.GPSButton.enabled = YES;
        [self.GPSButton setTitle:location forState:UIControlStateNormal];
    } faile:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        self.GPSButton.enabled = NO;
        [self.GPSButton setTitle:@"定位失败" forState:UIControlStateDisabled];
    }];
}

- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(40 + kButtonWidth, 10, kButtonHeight, kButtonHeight)];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activityIndicator.color = [DefineValue mainColor];
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.hideBlcok();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
