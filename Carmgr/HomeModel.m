//
//  HomeModel.m
//  Carmgr
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (instancetype)initWithDic:(NSDictionary*)dic {
    if (self = [super init]) {
        self.imageModel = dic[@"config_value_list"];
    }
    return self;
}

@end
