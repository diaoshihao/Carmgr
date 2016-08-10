//
//  DetailServiceModel.m
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DetailServiceModel.h"

@implementation DetailServiceModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.service_img = dict[@"service_img"];
        self.service_name = dict[@"service_name"];
        self.service_stars = dict[@"service_stars"];
        self.service_introduce = dict[@"service_introduce"];
        self.service_address = dict[@"service_address"];
        self.service_distance = dict[@"service_distance"];
        self.service_price = dict[@"service_price"];
    }
    return self;
}

@end
