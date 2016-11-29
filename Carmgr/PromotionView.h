//
//  Promotion.h
//  Carmgr
//
//  Created by admin on 2016/11/25.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonPosition) {
    PositionLeft = 0,
    
    PositionLeftTop,
    PositionLeftMiddle,
    PositionLeftBottom,
    
    PositionRightTop,
    PositionRightMiddle,
    PositionRightBottom,
};

typedef void(^LoadImage)(ButtonPosition position);

typedef void(^ButtonDidClick)(ButtonPosition position);


@interface PromotionView : UIView

@property (nonatomic, copy) ButtonDidClick click;

- (void)setImageFor:(ButtonPosition)position imageUrl:(NSString *)imageUrl;

@end


@interface DiscountView : UIView

@property (nonatomic, copy) ButtonDidClick click;

- (void)setDiscountImages:(NSArray *)images;

@end
