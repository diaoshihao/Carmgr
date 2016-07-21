//
//  UsedCarModel.m
//  Carmgr
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "UsedCarModel.h"

@implementation UsedCarModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.img_path = dict[@"img_path"];
        self.car_name = dict[@"car_name"];
        self.detail = dict[@"detail"];
        self.url = dict[@"url"];
    }
    return self;
}

@end
