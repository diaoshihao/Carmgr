//
//  LoadHomeData.m
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "HomeDataLoader.h"
#import "Interface.h"

@implementation HomeDataLoader
{
    NSUInteger _successCount;//成功请求次数
    NSUInteger _failureCount;//失败请求次数
    NSUInteger _returnCount;//所有请求次数
}

- (void)loadData {
    _successCount = 0;
    _failureCount = 0;
    _returnCount = 0;
    
    NSArray *config_0001 = [Interface appgetconfig_key:@"ZY_0001"];
    [MyNetworker POST:config_0001[InterfaceUrl] parameters:config_0001[Parameters] success:^(id responseObject) {
        [self autoAddSuccessCount];
        
        [self.dataSource loadConfig_key:Config_ZY0001 data:responseObject[@"config_value_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
    
    NSArray *config_0002 = [Interface appgetconfig_key:@"ZY_0002"];
    [MyNetworker POST:config_0002[InterfaceUrl] parameters:config_0002[Parameters] success:^(id responseObject) {
        [self autoAddSuccessCount];
        
        [self.dataSource loadConfig_key:Config_ZY0002 data:responseObject[@"config_value_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
    
    NSArray *config_0003 = [Interface appgetconfig_key:@"ZY_0003"];
    [MyNetworker POST:config_0003[InterfaceUrl] parameters:config_0003[Parameters] success:^(id responseObject) {
        [self autoAddSuccessCount];
        
        [self.dataSource loadConfig_key:Config_ZY0003 data:responseObject[@"config_value_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
    
    NSArray *config_0004 = [Interface appgetconfig_key:@"ZY_0004"];
    [MyNetworker POST:config_0004[InterfaceUrl] parameters:config_0004[Parameters] success:^(id responseObject) {
        [self autoAddSuccessCount];
        
        [self.dataSource loadConfig_key:Config_ZY0004 data:responseObject[@"config_value_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
    
    NSArray *config_0005 = [Interface appgetconfig_key:@"ZY_0005"];
    [MyNetworker POST:config_0005[InterfaceUrl] parameters:config_0005[Parameters] success:^(id responseObject) {
        [self autoAddSuccessCount];
        
        [self.dataSource loadConfig_key:Config_ZY0005 data:responseObject[@"config_value_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
    
    NSArray *services = [Interface appgetservices];
    [MyNetworker POST:services[InterfaceUrl] parameters:services[Parameters] responseCache:^(id responseCache) {
        [self autoAddSuccessCount];
        
    } success:^(id responseObject) {
        [self.dataSource loadServices:responseObject[@"services_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
    
    NSArray *secondhand = [Interface appgetsecondhandcar];
    [MyNetworker POST:secondhand[InterfaceUrl] parameters:secondhand[Parameters] responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        [self autoAddSuccessCount];
        
        [self.dataSource loadSecondHand:responseObject[@"car_list"]];
    } failure:^(NSError *error) {
        [self autoAddFailureCount];
    }];
}

- (void)autoAddSuccessCount {
    _successCount++;
    _returnCount++;
    if (_successCount == 7) {
        self.dataDidLoad = YES;
        [self.dataSource loadSuccess];
    }
    if (_returnCount == 7) {
        [self.dataSource requestAllDone];
    }
}

- (void)autoAddFailureCount {
    _failureCount++;
    _returnCount++;
    if (_failureCount == 7) {
        self.dataLoadFailed = YES;
        [self.dataSource loadFailed];
    }
    if (_returnCount == 7) {
        [self.dataSource requestAllDone];
    }
}



@end
