//
//  HomeModel.m
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    HomeModel *homeModel = [[HomeModel alloc] init];
    homeModel.config_value = dict[@"config_value"];
    homeModel.detail = dict[@"detail"];
    homeModel.sequence = dict[@"sequence"];
    homeModel.url = dict[@"url"];
    return homeModel;
}

@end


@implementation ServiceModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.icon_path = dict[@"icon_path"];
        self.service_name = dict[@"service_name"];
        self.url = dict[@"url"];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    ServiceModel *serviceModel = [[ServiceModel alloc] init];
    serviceModel.icon_path = dict[@"icon_path"];
    serviceModel.service_name = dict[@"service_name"];
    serviceModel.url = dict[@"url"];
    return serviceModel;
}

@end


@implementation UsedCarModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.img_path = dict[@"img_path"];
        self.car_name = dict[@"car_name"];
        self.detail = dict[@"detail"];
        self.url = dict[@"url"];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    UsedCarModel *usedCarModel = [[UsedCarModel alloc] init];
    usedCarModel.img_path = dict[@"img_path"];
    usedCarModel.car_name = dict[@"car_name"];
    usedCarModel.detail = dict[@"detail"];
    usedCarModel.url = dict[@"url"];
    return usedCarModel;
}

@end


