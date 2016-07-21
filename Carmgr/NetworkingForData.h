//
//  NetworkingForData.h
//  Carmgr
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkingForData : NSObject

@property (nonatomic, strong) UIViewController *target;

@property (nonatomic, strong) NSArray *propertys;

@property (nonatomic, strong) NSMutableArray *serviceDataArr;
@property (nonatomic, strong) NSMutableArray *usedCarDataArr;

@property (nonatomic) BOOL outDate;//token过期
@property (nonatomic) BOOL outLine;//网络中断


- (void)getSource:(dispatch_group_t)group;

- (void)getService:(dispatch_group_t)group;

- (void)getUsedCar:(dispatch_group_t)group;

//- (void)getHotSource:(dispatch_group_t)group;

@end
