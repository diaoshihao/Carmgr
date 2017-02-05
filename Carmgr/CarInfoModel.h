//
//  CarInfoModel.h
//  Carmgr
//
//  Created by admin on 2017/1/12.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "BasicModel.h"

@interface CarInfoModel : BasicModel

@property (nonatomic, strong) NSString *vehicle_brand;
@property (nonatomic, strong) NSString *vehicle_number;
@property (nonatomic, strong) NSString *engine_number;
@property (nonatomic, strong) NSString *frame_number;

@end
