//
//  DetailModel.m
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super initWithDict:dict]) {
        self.address = dict[@"address"];
        self.total_rate = dict[@"total_rate"];
        self.services_list = dict[@"services_list"];
        self.rate_list = dict[@"rate_list"];
    }
    return self;
}

@end
