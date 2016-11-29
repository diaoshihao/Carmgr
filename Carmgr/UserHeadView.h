//
//  UserHeadView.h
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ClickAtButton) {
    ButtonUserName = 10,
    ButtonMessage = 20,
    ButtonSetting = 30,
};

typedef void(^ButtonClick)(ClickAtButton buttonType);

@interface UserHeadView : UIView

@property (nonatomic, strong) UIImageView   *userImageView;
@property (nonatomic, strong) UIButton      *userName;

@property (nonatomic, copy) ButtonClick buttonClick;

@end
