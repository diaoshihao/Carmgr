//
//  CarInfoView.h
//  Carmgr
//
//  Created by admin on 2017/1/12.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *textLabel;

@end

typedef void(^DeleteCarBlock)(void);

@interface CarInfoView : UIView

@property (nonatomic, strong) NSArray *infoArr;

@property (nonatomic, copy) DeleteCarBlock deleteCarBlock;

- (instancetype)initWithInfo:(NSArray *)infoArr;

- (void)deleteCarAction:(DeleteCarBlock)deleteCarBlock;

@end
