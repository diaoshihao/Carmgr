//
//  AddCarInfoView.h
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCarInfoView : UIView

@property (nonatomic, strong) UIViewController  *target;
@property (nonatomic, strong) UIView            *superView;

- (UIButton *)createLabelAndButton:(UIView *)broview;

- (UISegmentedControl *)numberType;

- (UIView *)labelWithTitle:(NSString *)title size:(CGSize)size;

@end
