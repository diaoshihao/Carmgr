//
//  ContactView.h
//  Carmgr
//
//  Created by admin on 2016/12/29.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ContactWith) {
    ContactWithWeChat,
    ContactWithQQ,
    ContactWithPhone,
};

typedef void(^ContactBlock)(ContactWith contact);

typedef void(^SubscribeBlock)(void);

@interface ContactView : UIView

@property (nonatomic, copy) ContactBlock contactBlock;

@property (nonatomic, copy) SubscribeBlock subscribeBlock;

- (void)contactBegin:(ContactBlock)contactBlock;

- (void)subscribeBegin:(SubscribeBlock)subscribeBlock;

@end
