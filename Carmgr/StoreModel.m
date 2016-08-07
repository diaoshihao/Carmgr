//
//  StoreModel.m
//  Carmgr
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.img_path = dict[@"img_path"];
        self.merchant_name = dict[@"merchant_name"];
        self.stars = dict[@"stars"];
        self.service_item = dict[@"service_item"];
        self.mobile = dict[@"mobile"];
        self.merchant_introduce = dict[@"merchant_introduce"];
        self.province = dict[@"province"];
        self.city = dict[@"city"];
        self.area = dict[@"area"];
        self.road = dict[@"road"];
        self.distance = dict[@"distance"];
    }
    return self;
}

@end
