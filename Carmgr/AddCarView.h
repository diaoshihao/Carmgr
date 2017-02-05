//
//  AddCarView.h
//  Carmgr
//
//  Created by admin on 2017/1/11.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

//该类为添加车辆按钮界面view

#import <UIKit/UIKit.h>

typedef void(^AddCarInfoBlock)(void);

@interface AddCarView : UIView

@property (nonatomic, copy) AddCarInfoBlock addCarInfo;

- (void)beginAddCarInfo:(AddCarInfoBlock)addCarInfo;

@end
