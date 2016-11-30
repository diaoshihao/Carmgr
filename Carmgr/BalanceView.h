//
//  BalanceView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Balance) {
    PayManager,
    BankCard,
    WithdrawMoney,//提现
};

typedef void(^ButtonClick)(Balance);

@interface BalanceView : UIView

@property (nonatomic, assign) CGFloat balance;

@property (nonatomic, copy) ButtonClick buttonClick;

- (instancetype)initWithBalance:(CGFloat)balance;

@end
