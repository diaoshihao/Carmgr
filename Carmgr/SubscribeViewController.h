//
//  SubscribeViewController.h
//  Carmgr
//
//  Created by admin on 2017/1/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "SecondaryViewController.h"
#import "DetailServiceModel.h"

@interface SubscribeViewController : SecondaryViewController

@property (nonatomic, strong) DetailServiceModel *serviceModel;

@property (nonatomic, strong) NSString *merchant_id;

@end
