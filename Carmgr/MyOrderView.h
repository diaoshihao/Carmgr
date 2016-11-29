//
//  MyOrderView.h
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OrderProgress) {
    OrderProgressAll = 10,
    OrderProgressToPay,
    OrderProgressToUsed,
    OrderProgressDoing,
    OrderProgressDone,
    OrderProgressToComment,
    OrderProgressService,
};

typedef void(^Progress)(OrderProgress progress);

@interface MyOrderView : UIView

@property (nonatomic, copy) Progress progress;

@end
