//
//  DetailServiceModel.h
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailServiceModel : NSObject

@property (nonatomic, strong) NSString *service_img;
@property (nonatomic, strong) NSString *service_name;
@property (nonatomic, strong) NSString *service_introduce;
@property (nonatomic, strong) NSString *service_stars;
@property (nonatomic, strong) NSString *service_address;
@property (nonatomic, strong) NSString *service_distance;
@property (nonatomic, strong) NSString *service_price;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
