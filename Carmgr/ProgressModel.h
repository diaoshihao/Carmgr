//
//  ProgressModel.h
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressModel : NSObject

@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *merchant_account;
@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *order_state;
@property (nonatomic, strong) NSString *order_time;
@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *service_name;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
