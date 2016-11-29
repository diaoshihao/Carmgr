//
//  MessageModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *subTitle;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
