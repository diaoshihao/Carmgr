//
//  FilterView.h
//  Carmgr
//
//  Created by admin on 2016/12/27.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

//===================商家列表条件筛选===================

#import <UIKit/UIKit.h>
#import "CustomButton.h"

typedef NS_ENUM(NSUInteger, FilterType) {
    FilterTypeService,
    FilterTypeArea,
    FilterTypeSort,
    FilterTypeNone,
};

typedef void(^FilterTypeSelectBlock)(FilterType filterType);

@interface FilterView : UIView

@property (nonatomic, copy) FilterTypeSelectBlock filterBlock;

@property (nonatomic, strong) CustomButton *currentSelected;

- (void)filterTypeDidSelected:(FilterTypeSelectBlock)filterBlock;

@end
