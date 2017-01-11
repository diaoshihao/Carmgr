//
//  CarsPickerViewController.h
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "SecondaryViewController.h"

typedef void(^CarsPickBlock)(NSString *car);

@interface CarsPickerViewController : SecondaryViewController

@property (nonatomic, copy) CarsPickBlock pickBlock;

- (void)didPickCar:(CarsPickBlock)pickblock;

@end
