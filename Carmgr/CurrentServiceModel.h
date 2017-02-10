//
//  CurrentServiceModel.h
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "BasicModel.h"

@interface CurrentServiceModel : BasicModel

@property (nonatomic, strong) NSString *serviceName;

@property (nonatomic, strong) NSString *merchantName;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *stars;

@property (nonatomic, strong) NSString *uid;


@end
