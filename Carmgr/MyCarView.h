//
//  MyCarView.h
//  Carmgr
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddCarInfo)(void);

@interface MyCarView : UIView

@property (nonatomic, copy) AddCarInfo addCarInfo;

@end
