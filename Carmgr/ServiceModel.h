//
//  ImageModel.h
//  Carmgr
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (nonatomic, strong) NSString *icon_path;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *service_name;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
