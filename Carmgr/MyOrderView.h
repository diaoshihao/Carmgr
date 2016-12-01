//
//  MyOrderView.h
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

typedef NS_ENUM(NSUInteger, OrderProgress) {
    OrderProgressAll,
    OrderProgressToPay,
    OrderProgressToUsed,
    OrderProgressDoing,
    OrderProgressDone,
    OrderProgressToComment,
    OrderProgressService,
};

typedef void(^Progress)(OrderProgress progress);

@interface MyProgressView : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectedImages;

@property (nonatomic, copy) Progress progress;

@property (nonatomic, strong) CustomButton *currentSelected;

- (void)currentOrderState:(OrderProgress)progress;

@end

@interface MyOrderView : UIView

@property (nonatomic, strong) MyProgressView *progressView;

@end
