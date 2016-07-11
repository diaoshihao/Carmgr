//
//  ProgressModel.h
//  Carmgr
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressModel : NSObject

@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) NSString *timeString;

- (void)initWithDictonary:(NSDictionary *)dict;

@end
