//
//  HotModel.h
//  Carmgr
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject

@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *service_item;
@property (nonatomic, strong) NSString *service_name;
@property (nonatomic, strong) NSString *uptime;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
