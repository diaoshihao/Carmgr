//
//  HomeModel.h
//  Carmgr
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "BaseModel.h"
#import "ImageModel.h"

@interface HomeModel : NSObject

@property (nonatomic, strong) ImageModel *imageModel;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end
