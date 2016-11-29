//
//  MessageModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.time = dict[@"time"];
        self.imageUrl = dict[@"imageUrl"];
        self.subTitle = dict[@"subTitle"];
    }
    return self;
}

@end
