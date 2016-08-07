//
//  StoreModel.h
//  Carmgr
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSString *stars;
@property (nonatomic, strong) NSString *service_item;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *merchant_introduce;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *road;
@property (nonatomic, strong) NSString *distance;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
