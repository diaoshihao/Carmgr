//
//  HotModel.m
//  Carmgr
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.merchant_name = dict[@"merchant_name"];
        self.img_path = dict[@"img_path"];
        self.price = dict[@"price"];
        self.mobile = dict[@"mobile"];
        self.service_item = dict[@"service_item"];
        self.service_name = dict[@"stars"];
        self.uptime = dict[@"uptime"];
    }
    return self;
}

@end
