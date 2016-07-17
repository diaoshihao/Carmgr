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
        self.merchant_name = dict[@"merchant_name"];
        self.img_path = dict[@"img_path"];
        self.address = dict[@"address"];
        self.mobile = dict[@"mobile"];
        self.service_item = dict[@"service_item"];
        self.stars = dict[@"stars"];
        self.tags = dict[@"tags"];
        self.total_rate = dict[@"total_rate"];
    }
    return self;
}

@end
