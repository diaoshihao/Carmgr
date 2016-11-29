//
//  HomeModel.h
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic, strong) NSString *config_value;//imageUrl
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *sequence;
@property (nonatomic, strong) NSString *url;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end


@interface ServiceModel : NSObject

@property (nonatomic, strong) NSString *icon_path;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *service_name;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end


@interface UsedCarModel : NSObject

@property (nonatomic, strong) NSString *img_path;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *car_name;

@property (nonatomic, strong) NSString *detail;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

