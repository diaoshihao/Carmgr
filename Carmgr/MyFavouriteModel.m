//
//  MyFavouriteModel.m
//  Carmgr
//
//  Created by admin on 2016/12/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "MyFavouriteModel.h"

@implementation MyFavouriteModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([value isEqualToString:@"null"]) {
        return;
    }
    [super setValue:value forKey:key];
}

//对未定义key处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
