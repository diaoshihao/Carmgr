//
//  CurrentServiceModel.m
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CurrentServiceModel.h"

@implementation CurrentServiceModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.serviceName = dict[@"serviceName"];
        self.merchantName = dict[@"merchantName"];
        self.price = dict[@"price"];
    }
    return self;
}

@end
