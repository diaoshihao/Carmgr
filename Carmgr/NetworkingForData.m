//
//  NetworkingForData.m
//  Carmgr
//
//  Created by admin on 16/7/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "NetworkingForData.h"
#import "YWPublic.h"
#import "HomeView.h"

#import "ServiceModel.h"
#import "UsedCarModel.h"
#import "HotModel.h"

@interface NetworkingForData()

@property (nonatomic, strong) NSMutableArray    *sourceDataArr;//图片资源

@property (nonatomic, strong) NSArray           *imageArr;
@property (nonatomic, strong) NSArray           *titleArr;

@property (nonatomic, strong) NSMutableArray    *cycleImageArr;//轮播图组

@end

@implementation NetworkingForData
{
    NSString *username;
    NSString *token;
}

- (NSMutableArray *)cycleImageArr {
    if (_cycleImageArr == nil) {
        _cycleImageArr = [[NSMutableArray alloc] init];
    }
    return _cycleImageArr;
}

- (void)getSource:(dispatch_group_t)group {
    
    dispatch_group_enter(group);
    
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSString *screen_size = [NSString stringWithFormat:@"%lfx%lf",width,height];
    
    //网络URL数组
    NSMutableArray *urlStrArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.propertys.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"ZY_000%ld",(long)i+1];
        [urlStrArr addObject:[NSString stringWithFormat:kCONFIG,username,imageName,screen_size,token]];
    }
    
    dispatch_group_t sourcegroup = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("yiwuchebao.carmgr.gcd", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSString *urlStr in urlStrArr) {
        dispatch_group_enter(sourcegroup);
        
        NSUInteger index = [urlStrArr indexOfObject:urlStr];
        NSMutableArray *arrM = self.propertys[index];

        [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
                [arrM removeAllObjects];
                for (NSDictionary *dict in dataDict[@"config_value_list"]) {
                    [arrM addObject:dict[@"config_value"]];
                }
            } else {//token过期
                self.outDate = YES;
            }
            
            dispatch_group_leave(sourcegroup);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.outLine = YES;
            dispatch_group_leave(sourcegroup);
        }];
    }
    dispatch_group_notify(sourcegroup, queue, ^{
        dispatch_group_leave(group);
    });
    
}

//服务图标数据请求
- (void)getService:(dispatch_group_t)group {
    
    dispatch_group_enter(group);
    
    NSString *urlStr = [NSString stringWithFormat:kSERVICES,username,token];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            [self.serviceDataArr removeAllObjects];
            for (NSDictionary *dict in dataDict[@"services_list"]) {
                ServiceModel *model = [[ServiceModel alloc] initWithDict:dict];
                [self.serviceDataArr addObject:model];
            }
        } else {//token过期
            self.outDate = YES;
        }
        
        dispatch_group_leave(group);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.outLine = YES;
        dispatch_group_leave(group);
    }];
}

//获取二手车数据
- (void)getUsedCar:(dispatch_group_t)group {
    
    dispatch_group_enter(group);
    
    NSString *urlStr = [NSString stringWithFormat:kSECONDHAND,username,token];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];        
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            [self.usedCarDataArr removeAllObjects];
            for (NSDictionary *dict in dataDict[@"car_list"]) {
                UsedCarModel *model = [[UsedCarModel alloc] initWithDict:dict];
                [self.usedCarDataArr addObject:model];
            }
        } else {//token过期
            self.outDate = YES;
        }
        
        dispatch_group_leave(group);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.outLine = YES;
        dispatch_group_leave(group);
    }];
}

#if 0

//热门推荐
- (void)getHotSource:(dispatch_group_t)group {
    dispatch_group_enter(group);
    
    [YWPublic afPOST:[NSString stringWithFormat:kRECOMMEND,username,token] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"热门%@",dataDict);
        
        
        
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            [self.usedCarDataArr removeAllObjects];
            for (NSDictionary *dict in dataDict[@"car_list"]) {
                HotModel *model = [[HotModel alloc] initWithDict:dict];
                [self.usedCarDataArr addObject:model];
            }
        }
        
        dispatch_group_leave(group);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"热门资源请求失败%@",error);
        dispatch_group_leave(group);
    }];
}

#endif

@end
