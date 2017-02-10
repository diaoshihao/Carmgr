//
//  ForHelpView.h
//  Carmgr
//
//  Created by admin on 2017/2/7.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HelpBlock)(void);

@interface ForHelpView : UIView

@property (nonatomic, copy) HelpBlock helpBlock;

- (void)needForHelp:(HelpBlock)helpBlock;

@end
