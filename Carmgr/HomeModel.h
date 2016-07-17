//
//  HomeModel.h
//  Carmgr
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : NSObject

@property (nonatomic, strong) NSArray *cycleImageArr;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end
