//
//  AlertShowAssistant.h
//  Carmgr
//
//  Created by admin on 2017/2/5.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertShowAssistant : UIView

//handle为nil则该action不显示
+ (void)alertTip:(NSString *)tip message:(NSString *)message actionTitle:(NSString *)title defaultHandle:(void(^)(void))defaultHandle cancelHandle:(void(^)(void))cancelHandle;

@end
