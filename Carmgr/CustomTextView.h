//
//  CustomTextView.h
//  Carmgr
//
//  Created by admin on 2017/2/8.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, assign) NSInteger limitWords;

@end
