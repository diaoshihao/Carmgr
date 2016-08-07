//
//  CallView.h
//  Carmgr
//
//  Created by admin on 16/8/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallView : UIView

- (UIScrollView *)scrollView;

- (UITextField *)textField:(NSString *)placeholer;

- (UIButton *)button:(NSString *)title target:(id)target action:(SEL)action;

- (UILabel *)label:(NSString *)title;

@end
