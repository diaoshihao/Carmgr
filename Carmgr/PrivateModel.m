//
//  PrivateModel.m
//  Carmgr
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "PrivateModel.h"

@implementation PrivateModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.username = dict[@"username"];
        self.avatar = dict[@"avatar"];
        self.score = dict[@"score"];
        self.sex = dict[@"sex"];
        self.city = dict[@"city"];
        self.money = dict[@"money"];
        self.order_total_size = dict[@"order_total_size"];
        self.order_topay_size = dict[@"order_topay_size"];
        self.order_touse_size = dict[@"order_touse_size"];
        self.order_process_size = dict[@"order_process_size"];
        self.order_completed_size = dict[@"order_completed_size"];
        self.opt_state = dict[@"opt_state"];
        self.opt_info = dict[@"opt_info"];
    }
    return self;
}

@end
