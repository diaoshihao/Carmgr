//
//  RateModel.m
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "RateModel.h"

@implementation RateModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.rate_user = dict[@"rate_user"];
        self.rate_stars = dict[@"rate_stars"];
        self.rate_time = dict[@"rate_time"];
        self.rate_text = dict[@"rate_text"];
    }
    return self;
}

@end
