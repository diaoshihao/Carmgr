//
//  RateModel.h
//  Carmgr
//
//  Created by admin on 16/8/10.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RateModel : NSObject

@property (nonatomic, strong) NSString *rate_user;
@property (nonatomic, strong) NSString *rate_stars;
@property (nonatomic, strong) NSString *rate_time;
@property (nonatomic, strong) NSString *rate_text;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
