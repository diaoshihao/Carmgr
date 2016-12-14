//
//  MyFavouriteModel.h
//  Carmgr
//
//  Created by admin on 2016/12/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFavouriteModel : NSObject

@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *service_name;
@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSString *price;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
