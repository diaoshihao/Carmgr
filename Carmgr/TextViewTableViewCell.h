//
//  ForHelpTableViewCell.h
//  Carmgr
//
//  Created by admin on 2017/2/8.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"

@interface TextViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) CustomTextView *describeTextView;

@end
