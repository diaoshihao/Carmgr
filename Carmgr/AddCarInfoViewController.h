//
//  CarVerifyViewController.h
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "SecondaryViewController.h"

typedef void(^AddCarSuccessBlock)(void);

@interface AddCarInfoViewController : SecondaryViewController

@property (nonatomic, copy) AddCarSuccessBlock successBlock;

- (void)addCarInfoSuccessful:(AddCarSuccessBlock)successBlock;

@end
