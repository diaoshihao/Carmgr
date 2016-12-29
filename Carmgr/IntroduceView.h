//
//  IntroduceView.h
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface IntroduceView : UIView

@property (nonatomic, strong) NSString *introduce;

- (CustomButton *)moreButton;

@end
