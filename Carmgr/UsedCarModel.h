//
//  UsedCarModel.h
//  Carmgr
//
//  Created by admin on 16/7/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsedCarModel : NSObject

@property (nonatomic, strong) NSString *img_path;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *car_name;

@property (nonatomic, strong) NSString *detail;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
