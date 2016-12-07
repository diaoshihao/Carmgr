//
//  CurrentServiceModel.h
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentServiceModel : NSObject

@property (nonatomic, strong) NSString *serviceName;

@property (nonatomic, strong) NSString *merchantName;

@property (nonatomic, strong) NSString *price;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
