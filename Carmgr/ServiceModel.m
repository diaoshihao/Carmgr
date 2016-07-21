//
//  ImageModel.m
//  Carmgr
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.icon_path = dict[@"icon_path"];
        self.service_name = dict[@"service_name"];
        self.url = dict[@"url"];
    }
    return self;
}

@end
