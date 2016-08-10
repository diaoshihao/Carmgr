//
//  DetailModel.h
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "StoreModel.h"

@interface DetailModel : StoreModel

@property (nonatomic, strong) NSString  *address;
@property (nonatomic, strong) NSString  *total_rate;
@property (nonatomic, strong) NSArray   *services_list;
@property (nonatomic, strong) NSArray   *rate_list;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
