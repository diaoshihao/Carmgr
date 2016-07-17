//
//  StoreModel.h
//  Carmgr
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *stars;
@property (nonatomic, strong) NSString *service_item;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *total_rate;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
