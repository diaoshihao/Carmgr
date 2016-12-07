//
//  CustomSegmentedControl.m
//  Carmgr
//
//  Created by admin on 2016/12/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CustomSegmentedControl.h"
#import "DefineValue.h"

@implementation CustomSegmentedControl

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithItems:items];
    if (self) {
        [self setting];
    }
    return self;
}

- (void)setting {
    self.backgroundColor = [UIColor whiteColor];
    self.tintColor = [UIColor whiteColor];
    self.selectedSegmentIndex = 0;
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[DefineValue mainColor]} forState:UIControlStateSelected];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[DefineValue buttonColor]} forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
