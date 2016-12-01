//
//  HotCityTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickBlock)(UIButton *button);

typedef void(^hideAreaList)(void);

@interface HotCityTableViewCell : UITableViewCell

@property (nonatomic, copy) buttonClickBlock clickBlock;

@property (nonatomic, copy) hideAreaList hideBlcok;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotCitys:(NSArray *)hotCitys;

//- (void)clickTheButton:(buttonClickBlock)block;
- (void)buttonDidClick:(UIButton *)sender;

@end
