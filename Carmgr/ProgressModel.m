//
//  ProgressModel.m
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ProgressModel.h"

@implementation ProgressModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.img_path = dict[@"img_path"];
        self.merchant_account = dict[@"merchant_account"];
        self.merchant_name = dict[@"merchant_name"];
        self.order_id = dict[@"order_id"];
        self.order_state = dict[@"order_state"];
        self.order_time = dict[@"order_time"];
        self.order_type = dict[@"order_type"];
        self.service_name = dict[@"service_name"];
    }
    return self;
}

@end
